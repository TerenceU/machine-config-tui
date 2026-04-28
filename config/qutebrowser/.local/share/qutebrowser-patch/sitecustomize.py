"""Local qutebrowser runtime patch for statusbar hint-mode behavior."""

import builtins
import sys


_real_import = builtins.__import__


def _apply_patch(bar_module):
    from qutebrowser.config import config
    from qutebrowser.keyinput import modeman
    from qutebrowser.utils import usertypes

    if getattr(bar_module.StatusBar, "_terence_hint_patch", False):
        return

    def _patched_maybe_hide(self):
        """Hide the statusbar in hint mode while keeping other in-mode behavior."""
        strategy = config.val.statusbar.show
        tab = self._current_tab()
        if tab is not None and tab.data.fullscreen:
            self.hide()
        elif strategy == "never":
            self.hide()
        elif strategy == "in-mode":
            try:
                mode_manager = modeman.instance(self._win_id)
            except modeman.UnavailableError:
                self.hide()
            else:
                if mode_manager.mode in [usertypes.KeyMode.normal, usertypes.KeyMode.hint]:
                    self.hide()
                else:
                    self.show()
        elif strategy == "always":
            self.show()
        else:
            raise bar_module.utils.Unreachable

    def _patched_on_mode_entered(self, mode):
        """Update statusbar visibility while skipping hint mode."""
        if config.val.statusbar.show == "in-mode" and mode != usertypes.KeyMode.command:
            self.maybe_hide()

        mode_manager = modeman.instance(self._win_id)
        if mode_manager.parsers[mode].passthrough:
            self._set_mode_text(mode.name)
        if mode in [
            usertypes.KeyMode.insert,
            usertypes.KeyMode.command,
            usertypes.KeyMode.caret,
            usertypes.KeyMode.prompt,
            usertypes.KeyMode.yesno,
            usertypes.KeyMode.passthrough,
        ]:
            self.set_mode_active(mode, True)

    def _patched_on_mode_left(self, old_mode, new_mode):
        """Update statusbar visibility when leaving a mode."""
        if config.val.statusbar.show == "in-mode" and old_mode != usertypes.KeyMode.command:
            self.maybe_hide()

        mode_manager = modeman.instance(self._win_id)
        if mode_manager.parsers[old_mode].passthrough:
            if mode_manager.parsers[new_mode].passthrough:
                self._set_mode_text(new_mode.name)
            else:
                self.txt.setText("")
        if old_mode in [
            usertypes.KeyMode.insert,
            usertypes.KeyMode.command,
            usertypes.KeyMode.caret,
            usertypes.KeyMode.prompt,
            usertypes.KeyMode.yesno,
            usertypes.KeyMode.passthrough,
        ]:
            self.set_mode_active(old_mode, False)

    bar_module.StatusBar.maybe_hide = _patched_maybe_hide
    bar_module.StatusBar.on_mode_entered = _patched_on_mode_entered
    bar_module.StatusBar.on_mode_left = _patched_on_mode_left
    bar_module.StatusBar._terence_hint_patch = True


def _patched_import(name, globals=None, locals=None, fromlist=(), level=0):
    module = _real_import(name, globals, locals, fromlist, level)

    target = None
    if name == "qutebrowser.mainwindow.statusbar.bar":
        target = sys.modules.get("qutebrowser.mainwindow.statusbar.bar")
    elif name == "qutebrowser.mainwindow.statusbar" and fromlist and "bar" in fromlist:
        target = sys.modules.get("qutebrowser.mainwindow.statusbar.bar")

    if target is not None:
        _apply_patch(target)

    return module


builtins.__import__ = _patched_import
