#!/usr/bin/env bash

# setup
sudo dhclient -v eth2 # virtual machine
SUI='<ip>' # my machine

##########
# Task 1 #
##########
for host in $SUI 'mail.fer.hr' '161.53.19.1' 'imunes.net'; do
    printf "$host => "
    ping -c1 $host | grep ttl
done # my machine

##########
# Task 2 #
##########
# part 1
watch -n 0.5 netstat -ant # virtual machine
namp -O $SUI; namp -sV $SUI; namp -A $SUI # my machine

# part 2
sudo service apache2 start; \
sudo service mysql start;   \
sudo aptitude install proftpd telnetd bind9 # virtual machine

sudo nmap -sV localhost # virtual machine
nmap -sV $SUI # my machine

##########
# Task 3 #
##########
vim iptables.rules
sudo iptables-restore < iptables.rules
sudo nmap -sV localhost # virtual machine
nmap -sV $SUI # my machine

##########
# Task 4 #
##########
aircrack-ng SUI1_WEP.cap
aircrack-ng SUI2_WEP.cap
