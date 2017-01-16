# Permissions

### RECEIVE_BOOT_COMPLETED
 * dobiva obavijest kad se sustav podigne
   * ovo joj ne treba

### INTERNET
 * pristup internetu
   * ovo joj vjerojatno treba za skidanje wallpapera, ali koristi za maliciozne stvari


### ACCESS_COARSE_LOCATION
 * daje joj pristup približnoj lokaciji
   * ovo joj ne treba


### ACCESS_FINE_LOCATION
 * daje joj pristup točnoj lokaciji
   * ovo joj ne treba


### READ_PHONE_STATE
 * može pročitati broj koji mobitel koristi, na koju mrežu je spojen, trenutno uspostavljene pozive
   * ovo joj sigurno ne treba


### SET_WALLPAPER
 * dozvola za promjenu pozadine
   * jedina opravdana dozvola za ovakvu aplikaciju


### READ_CONTACTS
 * dozvola za čitanje kontakata
   * ne treba joj


### WRITE_CONTACTS
 * dozvola za mijenjanje kontakata
   * ne treba joj


### RECEIVE_SMS
 * dozvola da može primiti SMS
   * sigurno joj ne treba ovo


### READ_OWNER_DATA
 * dozvola za čitanje podatak o vlasniku uređaja
   * ovo joj ne treba


### READ_HISTORY_BOOKMARKS
### WRITE_HISTORY_BOOKMARKS
 * ove dozvole više ne postoje, služile su za čitanje i promjenu bookmarka u pregledniku

# Prepare source code

```bash
unzip -d lab5_apk lab5.apk
dex2jar-2.0/d2j-dex2jar.sh lab5_apk/classes.dex
java -jar decompiler.jar -jar classes-dex2jar.jar -o lab5_src
```

# Analysis

CutePuppiesWallpaper.java
 * glavna klasa, pokreće se intent BotService
BotService.java
 * pokreće BotClient, glavni parametri su ime servera i port (kite.dyndns-ip.com, 1500)
BotClient.java
 * pokreće BotUpdater
 * pokreće BotWorker
 * spaja se na server kite.dyndns-ip.com:1500
 * prima naredbe od servera te mu vraća tražene rezultate (povijest iz preglednika, 
 	instalirane aplikacije, lokaciju, primljene SMS-ove, ID uređaja)
BotWorker.java
 * izvršava sve gore navedene akcije koje mu BotClient naredi
 * interno koristi BotSMSHandler i BotLocationListener
BotSMSHandler.java
 * čeka da dođe SMS te sprema od koga i što je došlo u listu stringova
BotLocationHandler.java
 * čeka da dođe do promjene lokacije te ju spremi