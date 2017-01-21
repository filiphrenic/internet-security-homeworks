# Lab 5
# Android reverse engineering

> The text is in Croatian, but the assignment was to look at the app's manifest file, decompile it and analyze source.

U ovoj vježbi analizirat će se maliciozna "wallpaper" aplikacija za operacijski sustav Android.

Za upoznavanje s osnovama Android aplikacija preporučeno je pogledati:
```
https://developer.android.com/guide/components/fundamentals.html#Manifest
```

Preporuča se i analiza dozvola Android aplikacija jer one igraju veliku ulogu u sigurnosti aplikacija:
```
https://developer.android.com/reference/android/Manifest.permission.html
```

Primjer metodologije za otkrivanje zaraženih aplikacija može biti:

- Provjera izvora i funkcionalnosti: analiza izvora aplikacije (npr. neslužbena web stranica umjesto trgovine Google Play) i proučiti za što se aplikacija predstavlja. Ovaj korak je podloga za daljnje korake, no u ovoj vježbi se neće koristiti jer je već poznato da je aplikacija maliciozna.

- Provjera traženih dozvola: treba pregledati dozvole koje aplikacija koristi i usporediti s očekivanim dozvolama za funkciju koju pruža korisnicima. Ako aplikacija koristi više dozvola nego je očekivano, tada je kandidat za daljnju analizu.

- Podaci: temeljem zahtjevanih dozvola, može se napraviti matrica podataka kojima aplikacija može pristupiti.

- Povezivost: posljednji korak je analiza izvornog koda. Treba provjeriti otvara li aplikacija neke konekcije (i prema kojem poslužitelju) te koji se podaci prenose, postoje li oglašavačke (advertising) knjižnice i slično.

Dohvatite i raspakirajte datoteke za izvođenje vježbe:
```
$ wget http://public.tel.fer.hr/sui/zadatak5.tar.gz
$ tar xf zadatak5.tar.gz
$ cd zadatak5
```

Vaš je zadatak provjeriti aplikaciju lab5.apk.

1. Instalirajte potrebne alate prema uputama iz datoteke 
[Upute_za_instalaciju_lab5](http://public.tel.fer.hr/sui/Upute_za_instalaciju_lab5.html)

2. Usporedite tražene dozvole pristupa s očekivanim dozvolama za jednu ‘Wallpaper’ aplikaciju. 
Dozvole se mogu vidjeti u datoteci AndoridManifest.xml nakon poziva alata apktool:

```
$ apktool d lab5.apk
$ cd lab5
$ less AndoridManifest.xml
```

3. Priprema izvornog koda aplikacije

Operacijski sustav Andorid ima vlastiti virtualni stroj, koji se naziva Dalvik Virtual Machine (DVM). Format koji sadržava bytecode tog vritualnog stroja zove se DEX (Dalvik Executable). Izvršni kod android aplikacije prevodi se u format .dex, te su pakira u datoteku s ekstenzijom .apk. Iz datoteke .dex se reverznim inžinjeringom može dobiti izvorni kod u ne previše izmijenjenom stanju. Za to je potrebno koristiti alate dex2jar, unzip i procyon (tim redosljedom):

Datoteku lab5.apk raspakirajte u neki novi direktorij:
```
$ unzip lab5.apk -d lab5_extracted/
```

Datoteku s ekstenzijom .dex (classes.dex) pretvorite u .jar i dekompajlirate korištenjem alata procyon kojeg ste u instalaciji preimenovali u decompiler.jar:
```
$ cd lab5_extracted
$ <dex2jar_direktorij>/d2j-dex2jar.sh classes.dex
$ java -jar decompiler.jar -jar <put_do_jar_datoteke> -o <izlazna_mapa_za_izvorni_kod>
```

4. Analiza izvornog koda aplikacije

Analizom izvornog koda utvrdite koji dijelovi koda su maliciozni i rade ono što aplikacija po namjeni (Wallpaper) ne bi trebala raditi. Preporučen slijed analize izvornog koda je sljedeći: 
CutePuppiesWallpaper -> BotService -> BotClient -> BotWorker -> BotLocationHandler -> BotSMSHandler.

