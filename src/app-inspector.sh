#!/bin/bash
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'
adb install -r /root/src/apk/app-debug.apk
adb install -r /root/src/apk/app-debug-androidTest.apk

adb shell ps | grep com.android.commands.monkey | awk '{print $2}' | xargs adb shell kill -9

CMD="app-inspector -u $( adb devices | tail -2 |  awk '{print $1}' | grep -o '\b\([a-zA-Z0-9]\|emulator-5554\)\+\b') -s --verbose"
xterm -fg "green" -bg "black" -T "App-inspector" -n "App-inspector" -e "$CMD"
