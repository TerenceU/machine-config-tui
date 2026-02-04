function chisulrouter --wraps='sudo nmap -sn 192.168.1.0/24' --description 'alias chisulrouter=sudo nmap -sn 192.168.1.0/24'
    sudo nmap -sn 192.168.1.0/24 $argv
end
