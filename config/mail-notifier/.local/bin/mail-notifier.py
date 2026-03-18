#!/usr/bin/env python3
"""
mail-notifier.py - IMAP IDLE email notification service
Reads accounts automatically from aerc's accounts.conf.
Supports xoauth2 (via source-cred-cmd) and plain password auth.
"""

import imaplib
import subprocess
import logging
import signal
import sys
import socket
import configparser
import re
import time
from pathlib import Path
from urllib.parse import urlparse, unquote
from threading import Thread, Event

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.StreamHandler(sys.stdout)]
)
log = logging.getLogger(__name__)

AERC_ACCOUNTS_CONF = Path.home() / ".config/aerc/accounts.conf"
IDLE_TIMEOUT = 60        # Re-check every minute even if IDLE push is missed
RECONNECT_DELAY = 30     # seconds before reconnect on error


def parse_aerc_accounts(conf_path: Path) -> list[dict]:
    """Parse aerc accounts.conf and extract IMAP account info."""
    accounts = []

    config = configparser.RawConfigParser()
    config.read(conf_path)

    for section in config.sections():
        raw = dict(config[section])
        source = raw.get("source", "")

        # Only handle IMAP sources (imaps:// or imap://)
        if not source.startswith("imap"):
            log.debug(f"[{section}] Skipping non-IMAP source: {source}")
            continue

        try:
            # Strip auth scheme suffix (e.g. imaps+xoauth2 → imaps)
            clean_source = re.sub(r'\+\w+', '', source, count=1)
            parsed = urlparse(clean_source)

            host = parsed.hostname
            port = parsed.port or 993
            email = unquote(parsed.username or "") if parsed.username else ""

            # Determine auth method
            is_oauth2 = "+xoauth2" in source
            cred_cmd = raw.get("source-cred-cmd", "").strip('"')
            folder = raw.get("default", "INBOX")

            account = {
                "name": section,
                "email": email,
                "host": host,
                "port": port,
                "folder": folder,
                "is_oauth2": is_oauth2,
                "cred_cmd": cred_cmd,
                "password": unquote(parsed.password) if parsed.password else None,
            }
            accounts.append(account)
            log.debug(f"Parsed account: {section} → {email} @ {host}:{port}")

        except Exception as e:
            log.warning(f"[{section}] Failed to parse source URL: {e}")
            continue

    return accounts


def get_credential(account: dict) -> str:
    """Get OAuth2 token or plain password for the account."""
    if account["is_oauth2"] and account["cred_cmd"]:
        result = subprocess.run(
            account["cred_cmd"], shell=True,
            capture_output=True, text=True, timeout=30
        )
        if result.returncode != 0:
            raise RuntimeError(f"cred-cmd failed: {result.stderr.strip()}")
        return result.stdout.strip()
    elif account["password"]:
        return account["password"]
    else:
        raise RuntimeError("No credential method available (no cred-cmd, no password)")


def connect_imap(account: dict) -> imaplib.IMAP4_SSL:
    """Connect and authenticate to IMAP server."""
    imap = imaplib.IMAP4_SSL(account["host"], account["port"])
    credential = get_credential(account)

    if account["is_oauth2"]:
        auth_string = f"user={account['email']}\x01auth=Bearer {credential}\x01\x01"
        imap.authenticate("XOAUTH2", lambda x: auth_string)
    else:
        imap.login(account["email"], credential)

    return imap


def send_notification(account_name: str, folder: str, subject: str, sender: str):
    title = f"[{account_name}/{folder}] New mail"
    body = f"From: {sender}\n{subject}"
    try:
        subprocess.run(
            ["notify-send", "--urgency=normal", "--icon=mail-unread", title, body],
            timeout=5,
            check=True,
        )
        log.info(f"Notification sent: {title} | {body}")
    except Exception as e:
        log.warning(f"notify-send failed: {e}")


def search_unseen(imap: imaplib.IMAP4_SSL, folder: str) -> set[bytes]:
    """Return stable IMAP UIDs for unseen messages in the selected folder."""
    status, _ = imap.select(folder, readonly=True)
    if status != "OK":
        raise RuntimeError(f"select {folder} failed: {status}")

    status, data = imap.uid("search", None, "UNSEEN")
    if status != "OK":
        raise RuntimeError(f"UID SEARCH UNSEEN failed: {status}")

    return set(data[0].split()) if data and data[0] else set()


def fetch_headers(imap: imaplib.IMAP4_SSL, uid: bytes) -> tuple[str, str]:
    """Fetch subject and sender for a message UID."""
    status, msg_data = imap.uid("fetch", uid, "(BODY.PEEK[HEADER.FIELDS (FROM SUBJECT)])")
    if status != "OK" or not msg_data or not msg_data[0]:
        raise RuntimeError(f"UID FETCH failed for {uid!r}")

    raw = msg_data[0][1].decode("utf-8", errors="replace")
    subject, sender = "", ""
    for line in raw.splitlines():
        if line.lower().startswith("subject:"):
            subject = line[8:].strip()
        elif line.lower().startswith("from:"):
            sender = line[5:].strip()
    return subject or "(no subject)", sender or "unknown"


def idle_once(imap: imaplib.IMAP4_SSL, account_name: str) -> None:
    """Wait for one IDLE cycle and drain the server response cleanly."""
    tag = f"IDLE{int(time.monotonic() * 1000)}".encode()
    imap.send(tag + b" IDLE\r\n")

    ack = imap.readline()
    if not ack.startswith(b"+"):
        raise RuntimeError(f"IDLE start failed: {ack!r}")

    imap.socket().settimeout(IDLE_TIMEOUT)
    try:
        line = imap.readline()
        log.debug(f"[{account_name}] IDLE server event: {line!r}")
    except socket.timeout:
        log.debug(f"[{account_name}] IDLE timeout, polling unseen state")
    finally:
        imap.socket().settimeout(None)

    imap.send(b"DONE\r\n")
    while True:
        line = imap.readline()
        if not line:
            raise RuntimeError("EOF while leaving IDLE")
        if line.startswith(tag):
            break


def watch_account(account: dict, stop_event: Event):
    name = account["name"]
    folder = account["folder"]
    known_unseen: set[bytes] | None = None

    while not stop_event.is_set():
        imap = None
        try:
            log.info(f"[{name}] Connecting to {account['host']}:{account['port']}...")
            imap = connect_imap(account)
            log.info(f"[{name}] Authenticated OK")

            current_unseen = search_unseen(imap, folder)
            if known_unseen is None:
                known_unseen = current_unseen
                log.info(f"[{name}] Watching {folder} ({len(known_unseen)} existing unseen)")
            else:
                missed_uids = current_unseen - known_unseen
                if missed_uids:
                    log.info(f"[{name}] Found {len(missed_uids)} unseen message(s) after reconnect")
                    for uid in sorted(missed_uids)[-5:]:
                        try:
                            subject, sender = fetch_headers(imap, uid)
                            send_notification(name, folder, subject, sender)
                        except Exception as e:
                            log.warning(f"[{name}] Error fetching missed message: {e}")
                            send_notification(name, folder, "New message", "")
                known_unseen = current_unseen

            while not stop_event.is_set():
                idle_once(imap, name)
                current_unseen = search_unseen(imap, folder)
                new_uids = current_unseen - known_unseen

                if new_uids:
                    log.info(f"[{name}] {len(new_uids)} new message(s)!")
                    for uid in sorted(new_uids)[-5:]:
                        try:
                            subject, sender = fetch_headers(imap, uid)
                            send_notification(name, folder, subject, sender)
                        except Exception as e:
                            log.warning(f"[{name}] Error fetching message: {e}")
                            send_notification(name, folder, "New message", "")

                known_unseen = current_unseen

        except Exception as e:
            log.error(f"[{name}] Error: {e}")
            if not stop_event.is_set():
                log.info(f"[{name}] Reconnecting in {RECONNECT_DELAY}s...")
                stop_event.wait(RECONNECT_DELAY)
        finally:
            if imap:
                try:
                    imap.logout()
                except Exception:
                    pass


def main():
    stop_event = Event()

    def shutdown(sig, frame):
        log.info("Shutting down...")
        stop_event.set()
        sys.exit(0)

    signal.signal(signal.SIGTERM, shutdown)
    signal.signal(signal.SIGINT, shutdown)

    accounts = parse_aerc_accounts(AERC_ACCOUNTS_CONF)
    if not accounts:
        log.error(f"No IMAP accounts found in {AERC_ACCOUNTS_CONF}")
        sys.exit(1)

    log.info(f"Found {len(accounts)} account(s): {[a['name'] for a in accounts]}")

    threads = []
    for account in accounts:
        t = Thread(target=watch_account, args=(account, stop_event), daemon=True)
        t.start()
        threads.append(t)

    stop_event.wait()


if __name__ == "__main__":
    main()



def get_token(token_file: str) -> str:
    result = subprocess.run(
        ["python3", "/home/terence/.config/aerc/mutt_oauth2.py", token_file],
        capture_output=True, text=True, timeout=30
    )
    if result.returncode != 0:
        raise RuntimeError(f"Failed to get OAuth2 token: {result.stderr.strip()}")
    return result.stdout.strip()


def send_notification(account_name: str, folder: str, subject: str, sender: str):
    title = f"[{account_name}/{folder}] New mail"
    body = f"From: {sender}\n{subject}"
    try:
        subprocess.run(
            ["notify-send", "--urgency=normal", "--icon=mail-unread", title, body],
            timeout=5
        )
        log.info(f"Notification sent: {title} | {body}")
    except Exception as e:
        log.warning(f"notify-send failed: {e}")


def get_new_mail_info(imap: imaplib.IMAP4_SSL, folder: str):
    """Fetch subject and sender of unseen messages."""
    imap.select(folder, readonly=True)
    _, data = imap.search(None, "UNSEEN")
    uids = data[0].split() if data[0] else []
    results = []
    for uid in uids[-5:]:  # max 5 notifications at once
        try:
            _, msg_data = imap.fetch(uid, "(BODY.PEEK[HEADER.FIELDS (FROM SUBJECT)])")
            raw = msg_data[0][1].decode("utf-8", errors="replace") if msg_data[0] else ""
            subject = ""
            sender = ""
            for line in raw.splitlines():
                if line.lower().startswith("subject:"):
                    subject = line[8:].strip()
                elif line.lower().startswith("from:"):
                    sender = line[5:].strip()
            results.append((subject or "(no subject)", sender or "unknown"))
        except Exception:
            results.append(("New message", ""))
    return results


def watch_account(account: dict, stop_event: Event):
    name = account["name"]
    host = account["host"]
    port = account["port"]
    folder = account["folder"]
    token_file = account["token_file"]

    while not stop_event.is_set():
        imap = None
        try:
            log.info(f"[{name}] Connecting to {host}:{port}...")
            token = get_token(token_file)
            auth_string = f"user={account['email']}\x01auth=Bearer {token}\x01\x01"

            imap = imaplib.IMAP4_SSL(host, port)
            imap.authenticate("XOAUTH2", lambda x: auth_string)
            log.info(f"[{name}] Authenticated OK")

            # Get initial unseen count (don't notify for existing mail)
            imap.select(folder, readonly=True)
            _, data = imap.search(None, "UNSEEN")
            known_unseen = set(data[0].split()) if data[0] else set()
            log.info(f"[{name}] Watching {folder} ({len(known_unseen)} existing unseen)")

            while not stop_event.is_set():
                # Send IDLE command
                imap.send(b"IDLE_TAG IDLE\r\n")
                imap.readline()  # "+ idling" response

                # Wait for server push or timeout
                imap.socket().settimeout(IDLE_TIMEOUT)
                try:
                    response = imap.readline()
                    log.debug(f"[{name}] IDLE response: {response}")
                except socket.timeout:
                    log.debug(f"[{name}] IDLE timeout, refreshing...")

                # Stop IDLE
                imap.send(b"DONE\r\n")
                imap.readline()

                # Refresh token and check for new messages
                token = get_token(token_file)
                auth_string = f"user={account['email']}\x01auth=Bearer {token}\x01\x01"

                imap.select(folder, readonly=True)
                _, data = imap.search(None, "UNSEEN")
                current_unseen = set(data[0].split()) if data[0] else set()
                new_uids = current_unseen - known_unseen

                if new_uids:
                    log.info(f"[{name}] {len(new_uids)} new message(s)!")
                    # Fetch info for new messages only
                    imap2 = imaplib.IMAP4_SSL(host, port)
                    imap2.authenticate("XOAUTH2", lambda x: auth_string)
                    imap2.select(folder, readonly=True)
                    for uid in list(new_uids)[-5:]:
                        try:
                            _, msg_data = imap2.fetch(uid, "(BODY.PEEK[HEADER.FIELDS (FROM SUBJECT)])")
                            raw = msg_data[0][1].decode("utf-8", errors="replace") if msg_data[0] else ""
                            subject, sender = "", ""
                            for line in raw.splitlines():
                                if line.lower().startswith("subject:"):
                                    subject = line[8:].strip()
                                elif line.lower().startswith("from:"):
                                    sender = line[5:].strip()
                            send_notification(name, folder, subject or "(no subject)", sender or "unknown")
                        except Exception as e:
                            log.warning(f"[{name}] Error fetching message: {e}")
                            send_notification(name, folder, "New message", "")
                    imap2.logout()

                known_unseen = current_unseen

        except Exception as e:
            log.error(f"[{name}] Error: {e}")
            if imap:
                try:
                    imap.logout()
                except Exception:
                    pass
            if not stop_event.is_set():
                log.info(f"[{name}] Reconnecting in {RECONNECT_DELAY}s...")
                stop_event.wait(RECONNECT_DELAY)

        finally:
            if imap:
                try:
                    imap.logout()
                except Exception:
                    pass


def main():
    stop_event = Event()

    def shutdown(sig, frame):
        log.info("Shutting down...")
        stop_event.set()
        sys.exit(0)

    signal.signal(signal.SIGTERM, shutdown)
    signal.signal(signal.SIGINT, shutdown)

    threads = []
    for account in ACCOUNTS:
        t = Thread(target=watch_account, args=(account, stop_event), daemon=True)
        t.start()
        threads.append(t)
        log.info(f"Started watcher for {account['name']}")

    stop_event.wait()


if __name__ == "__main__":
    main()
