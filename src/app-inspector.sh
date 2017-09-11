#!/bin/bash
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'
adb install -r /root/src/apk/app-debug.apk
adb install -r /root/src/apk/app-debug-androidTest.apk
CMD="app-inspector -u $(adb devices | grep -o '\b\([a-f0-9]\|emulator-5554\)\+\b') -s --verbose"
xterm -fg "green" -bg "black" -T "App-inspector" -n "App-inspector" -e "$CMD"
