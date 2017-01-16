# Lab 3
# Network protocols security and firewall

Before fetching the assignment files in the virtual machine settings add a
"Bridged network adapter" to the virtual machine.

Guide:

Right click on the virtual machine --> Settings... --> Network -> Adapter 3 -->
tick Enable Network adapter --> Attached to: Bridged Adapter --> Name: name of
the network adapter attached to your network --> OK

Start the virtual machine.
Login into the virtual machine as the user sui i and start DHCP configuration of
the new network interface by using DHCP:
```
    $ sudo dhclient -v eth2
```
Write down the IP address that is shown on your screen. This is the external IP
address of your virtual machine that will be used for virtual machine scanning
and access.

Run the following commands:
```
    $ wget http://public.tel.fer.hr/sui/assignment3.tar.gz
    $ tar xf assignment3.tar.gz
    $ cd zadatak3
```

The assignment consists of 4 parts:
## 1) Ping scanning

NOTE: This part is executed on your local machine, not the virtual machine.
With the `ping` command ping the following machines:

    1. your virtual machine
    2. mail.fer.hr
    3. 161.53.19.1
    4. imunes.tel.fer.hr

Study the returned TTL values. Deduct the starting TTL values. Can you conclude
which operating system is currently running on those virtual machines? Explain.

## 2) Nmap scanning

NOTE: This part is executed on your local machine, not the virtual machine.
Before starting the scan, inside the virtual machine start the following command
which will enable you to monitor incoming connections to the virtual machine:
```
    $ watch -n 0.5 netstat -ant
```

With the `nmap` tool discover currently running services on the virtual machine.
Test the following `nmap` possibilities:
 - scanning of TCP i UDP ports
 - TCP syn scan
 - operating system detection (-O)
 - detect running services versions (-sV)
 - general scan (-A flag)
Which scanning method could be detected on the virtual machine. Explain.

On the scanning machine you can start the Wireshark tool to see all the traffic
that `nmap` generates.

On the virtual machine start `apache2` and `mysql` services:
```
    $ sudo service apache2 start
    $ sudo service mysql start
```
Additionally install `proftpd`, `telnetd` and bind:
```
    $ sudo aptitude install proftpd telnetd bind9
```
Start the scanning with the -sV option.
Compare your scan results with the output of the following command:
```
    $ sudo nmap -sV localhost
```
How do they differ? Explain.

## 3) Firewall configuration

In the assignment3 directory which you unpacked previously there are two
files that begin with iptables:
    - `iptables.clean` - used for setting initial firewall rules, all traffic is
      let through the firewall
    - `iptables.rules` - has a set of firewall rules that needs to be updated
To apply firewall rules run the following commands:

```
    $ sudo iptables-restore < iptables.clean
    $ sudo iptables-restore < iptables.rules
```

In the `iptables.rules` file add the rules that match the comments in the file:
```
    # 2. ACCEPT dns from local network
    # 3. ACCEPT http from everywhere
    # 4. ACCEPT ftp from everywhere
    # 5. ACCEPT ping from local machine
    # 6. ACCEPT telnet from local machine
    # 7. REJECT everything else with icmp-port-unreachable
```

For testing firewall rules use `nmap`.

Describe the difference when scanning ports with and without 7th rule. Explain.
Which rule is better from a security perspective? Explain.

## 4) Wireless network WEP cracking

In the assignment directory there are two pcap (packet capture) files that have
packet from 2 attacks on a wireless network protected by the WEP standard. With
the aircrack-ng tool discover the password of both wireless networks.

Examine both pcap files in the Wireshark tool on your operating system. How do
the files differ. 

In the Wireshark WLAN network settings (Edit menu -> Preferences... ->
Protocols -> IEEE 802.11) tick "Enable decryption" and add the WEP wireless keys in
the "Decryption keys" window. Examine which data is exchanged with the server
located on 161.53.19.80. Which file is being downloaded, which protocol is used
to download it? (Use the "Follow TCP Stream" option, available by right clicking
a packet in the stream)

## Assignment results

You **need to send** the following data by email to
[sui@fer.hr](mailto:sui@fer.hr) after solving the assignment: 

- **report** on the subject in **PDF format** (should not exceed **1000 words**)
  which contains the procedure that you used to solve the assigment along with
  answers to assignment questions
- list all of **successful commands** used to complete the assignment
- **final version** of the `iptables.rules` file

## Tools for this assignment

- `ping` - check network connectivity.
- `nmap` - scanning machines and services on the network. You need to download and
  install it for your operating system. You can also use Zenmap. 
- `netstat` - overview of currently active network services on the local machine.
- `service` -  starting and stopping services on the Debian operating system.
- `iptables` - firewall configuration on Debian.
- `wireshark` - network traffic analysis. Downloaded and installed for your
  operating system (http://www.wireshark.org/)
- `aircrack-ng` - wireless network password cracking tool.
