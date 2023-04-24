# System Root CA on Android

To be able properly intercept SSL traffic for apps which does not have SSL pinning, but does not trust User added CAs on Android device, you need to add it to System space. Previuosly I would do that by re-mounting /system as RW, but with latest Magisk and OS on my Android test device could not do. After quick review, created a bash script which uses zip to archive and openSSL to get hashes, this is all that needed to create a Module for Magisk.

## How to use

Get the script onto your machine, make it executable, get cacert.der (default name for BURP cert, you can use whatever you want).

*chmod +x addCert.sh*
*./addCert.sh cacert.der*

This will create MagiskModule.zip file, which you transfer to your Android (use adb, any HTTP server, etc.) and install as Magisk module. After reboot, your CA is within Trusted System CAs.


## NOTE:
If you want to have more than one CA, just add appropriately created file into zip's system/etc/security/cacerts/ folder (or run script multiple times with renaming of files and combine those).

Tested on OSX only at this time

ENJOY!
