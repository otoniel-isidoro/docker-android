#!/bin/bash
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'
adb install -r ./apk/app-debug.apk
adb install -r ./apk/app-debug-androidTest.apk
app-inspector -u emulator-5554 --verbose