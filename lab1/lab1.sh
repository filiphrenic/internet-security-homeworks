#!/usr/bin/env bash

# data.bin sha256
DATA_SHA256="3059724a4a32088244560552b09bb425db76f71c6143ed0af20ae62b7861ea96"

# Download files
wget http://public.tel.fer.hr/sui/zadatak1.tar.gz
tar xf zadatak1.tar.gz && rm zadatak1.tar.gz
cd zadatak1
rm PROCITAJ_ME README # don't need

# Task 1
file * # file descriptions
gpg --import key.gpg # import key
gpg --verify secret.bin # verify signature
for w in `gpg --decrypt secret.bin 2>/dev/null`; do printf ${w::1}; done | gpg --passphrase-fd 0 --output data --decrypt data.bin
[[ "$DATA_SHA256" = `sha256sum data | awk '{print $1}'` ]] || echo 'ne poklapa se sha256'

# Task 2
file data # mp4
# run on host machine
# scp -P 2202 sui@localhost:zadatak1/data video.mp4 && open video.mp4

# Task 3
gpg --gen-key
echo "Filip Hrenić 00364775862" > jmbag.txt
gpg --output jmbag.txt.gpg --sign jmbag.txt
gpg --export -a "Filip Hrenic" > fh.gpg.pub.key

# Task 4
echo "Ovo je moja tajna za sui@fer.hr hehe" > mysecret
gpg -r 'Internet Security' --output mysecret.gpg --encrypt mysecret

# Task 5.a
ALGS='aes-256-ecb des-ede3 aes-256-cbc des-ede3-cbc aes-256-ctr'
dd if=/dev/urandom of=/tmp/data bs=10K count=5000
for alg in $ALGS; do
    enc=`{ time openssl enc    -$alg -in /tmp/data     -out /tmp/data.enc -k sui; } 2>&1 | grep real | awk '{print $2}'`
    dec=`{ time openssl enc -d -$alg -in /tmp/data.enc -out /tmp/data.dec -k sui; } 2>&1 | grep real | awk '{print $2}'`
    diff /tmp/data /tmp/data.dec
    rm /tmp/data.enc /tmp/data.dec
    echo -e "\nAlgortithm $alg\n    time.enc: $enc\n    time.dec: $dec"1
done
rm /tmp/data

# aes je višestruko brži i sigurniji od des-a
# aes.cbc je sporiji od aes.{ecb,ctr} 2 puta za enkripciju
# des (~2s enc i dec) je nekoliko desetaka puta sporiji od aes-a (~0.12s enc i dec)

# Task 5.b

# verify je brži od sign za rsa i ecdsa
# s porastom bitova rastu oba (verify i sign)

openssl speed rsa 2> /dev/null | grep '^rsa' | awk '{print $4, $5, $4 / $5}'
# s porastom bitova x2, sign.time porast je ~ x8 a verify.time ~ x4
# za rsa je brži verify od sign
# => omjer verify/sign brzina prema tome raste ~ x2

openssl speed ecdsa 2> /dev/null | grep 'bit ecdsa' | awk '{print $5, $6, $6 / $5}'
# s porastom bitova rastu i sign.time i verify.time
# za ecdsa brži je sign of verify
# omjer sign/verify je ~ 2
