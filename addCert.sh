#!/bin/bash
tname=$(openssl x509 -inform DER -subject_hash_old -in $1 | head -1).0
openssl x509 -in $1 -inform DER -out $tname
mkdir -p system/etc/security/cacerts/
mv $tname system/etc/security/cacerts/
echo id=AddMyCert > module.prop
echo name=AddMyCert >> module.prop
echo version=v1.0 >> module.prop
echo author=zalt3es >> module.prop
echo description=Add your Root Certificate\(\-s\) >> module.prop

mkdir -p META-INF/com/google/android/
echo \#\!/sbin/sh > META-INF/com/google/android/update-binary
echo \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\# >> META-INF/com/google/android/update-binary
echo \# Initialization >>META-INF/com/google/android/update-binary
echo \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\# >> META-INF/com/google/android/update-binary
echo >> META-INF/com/google/android/update-binary
echo umask 022 >> META-INF/com/google/android/update-binary
echo ui_print\(\) \{ echo \"\$1\"\; \} >>  META-INF/com/google/android/update-binary
echo require_new_magisk\(\) \{ >>  META-INF/com/google/android/update-binary
echo  ui_print \"*******************************\" >> META-INF/com/google/android/update-binary
echo  ui_print \" Please install Magisk v20.4+! \" >> META-INF/com/google/android/update-binary
echo  ui_print \"*******************************\" >> META-INF/com/google/android/update-binary
echo  exit 1 >> META-INF/com/google/android/update-binary
echo \} >> META-INF/com/google/android/update-binary
echo \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\# >> META-INF/com/google/android/update-binary
echo \# Load util_functions.sh >> META-INF/com/google/android/update-binary
echo \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\# >> META-INF/com/google/android/update-binary
echo OUTFD=\$2 >> META-INF/com/google/android/update-binary
echo ZIPFILE=\$3 >> META-INF/com/google/android/update-binary
echo mount /data 2\>/dev/null >> META-INF/com/google/android/update-binary
echo  >> META-INF/com/google/android/update-binary
echo \[ \-f /data/adb/magisk/util_functions.sh \] \|\| require_new_magisk >> META-INF/com/google/android/update-binary
echo . /data/adb/magisk/util_functions.sh >> META-INF/com/google/android/update-binary
echo \[ \$MAGISK_VER_CODE \-lt 20400 \] \&\& require_new_magisk >> META-INF/com/google/android/update-binary
echo  >> META-INF/com/google/android/update-binary
echo install_module >> META-INF/com/google/android/update-binary
echo exit 0 >> META-INF/com/google/android/update-binary
echo \#MAGISK > META-INF/com/google/android/updater-script

echo All files should be in place, let\'s zip

zip -r -m MagiskModule.zip system/ META-INF/ module.prop
