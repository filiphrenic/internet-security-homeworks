#! /usr/bin/env bash

# setup
wget http://public.tel.fer.hr/sui/zadatak5.tar.gz
tar xf zadatak5.tar.gz
cd zadatak5

# install java
sudo apt-get update  -y
sudo apt-get install -y default-jre default-jdk

# install apktool
wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.2.1.jar
mv apktool_2.2.1.jar apktool.jar
chmod +x apktool.jar
chmod +x apktool
sudo mv apktool.jar apktool /usr/local/bin

# install dex2jar
wget https://sourceforge.net/projects/dex2jar/files/dex2jar-2.0.zip
unzip -x dex2jar-2.0.zip
rm dex2jar-2.0.zip
chmod +x dex2jar-2.0/*

# install procyon
wget https://bitbucket.org/mstrobel/procyon/downloads/procyon-decompiler-0.5.30.jar
mv procyon-decompiler-0.5.30.jar decompiler.jar
java -jar decompiler.jar 

echo -e "\n\nINSTALLATION DONE\n"



