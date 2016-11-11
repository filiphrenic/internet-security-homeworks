#!/usr/bin/env bash

USERNAME='sui2'
PASSWORD='Internet1'

# Download files
wget http://public.tel.fer.hr/sui/zadatak2.tar.gz
tar xf zadatak2.tar.gz && rm zadatak2.tar.gz
cd zadatak2

# Task 1
echo "/usr/sbin/adduser sui sudo" > /tmp/smth # wait less than a minute
# logout & login -> sudo works
sudo cat /etc/sudoers | grep '%sudo' && rm /tmp/smth

# Task 2
sudo adduser ${USERNAME}
# linije u shadow nisu iste ako su iste sifre
# jer je koristen drukciji salt za hash lozinke
# objasni zasto se to tak radi
# koristi se sha-512 -> oznaka $6$
sudo cat /etc/shadow | grep -E "${USERNAME}|sui" | cut -d: -f2 # print passwords
sudo cat /etc/shadow | sed -nE "s/${USERNAME}\:\$6\$([^\$]+)\$.*/\1/p" | xargs mkpasswd -m sha-512 ${PASSWORD}

# Task 3

sudo rm /root/.john/john.pot # clean start
for passfile in pass_*; do
    printf "$passfile => "
    { time sudo john $passfile > /dev/null; } 2>&1 | grep real | awk '{print $2}'
done
# razlika je u saltu. kod week je koristen isti salt za sve sifre pa ih john lakše cracka
# john radi s metodom "dictionary attack". uzima riječi iz nekog riječnika, hashira ih
# istim algoritmom kao i lozinke koje se žele orkiti te usporeduje ta 2 hasha

#rezultati:
# pass_MD5          =>  0m  7.049s
# pass_SHA-256_weak =>  0m 14.016s
# pass_SHA-512_weak =>  0m 44.318s
# pass_SHA-256      =>  4m  7.409s
# pass_SHA-512      => 13m 49.026s

# Task 4
strings malware1.txt
# ovo je rootkit. dodaje web stranicu na server koju koristi kao backdoor za upad
string malware2.txt
# ovo je alat za floodanje servera (?)
