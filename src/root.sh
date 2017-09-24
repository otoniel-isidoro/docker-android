#!/bin/bash
# https://android.stackexchange.com/questions/171442/root-android-virtual-device-with-android-7-1-1/176447
#
# adb -e wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'
# adb -e root
# adb -e remount
# adb -e install -r /root/src/apk/SuperSU.apk
# adb -e push /root/src/su /system/xbin/su
# adb -e shell su root -c "chmod 06755 /system/xbin/su"
# adb -e shell su root -c "su --install"
# adb -e shell su root -c "su --daemon&"
# adb -e shell su root -c "setenforce 0"
# adb -e shell stop
# adb -e shell start

#https://android.stackexchange.com/questions/179482/android-emulator-install-failed-no-matching-abis-failed-to-extract-native-lib
# adb -e wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'
# adb root
# adb remount
# adb shell mkdir /system/lib64/arm64
# adb push /root/src/zip /system/bin/zip
# adb push /root/src/unzip /system/xbin/unzip
# adb push /root/src/hexdump /system/xbin/hexdump
# adb push /root/src/wget /system/xbin/wget
# adb push /root/src/gzip /system/xbin/gzip
# adb push /root/src/gunzip /system/xbin/gunzip
# adb push /root/src/enable_houdini.sh /system/xbin/
# adb push /root/src/houdini64.tar.gz /data/local/houdini64.tar.gz
# adb shell tar xvf /data/local/houdini64.tar.gz -C /system/lib64/arm64/
# adb shell enable_houdini.sh 64
# adb shell stop 
# adb shell start