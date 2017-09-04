#!/bin/bash

if [ -z "$REAL_DEVICE" ] || [ $REAL_DEVICE == "false" ]; then
  echo "Container is using android emulator"
else
  adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'
  echo "Starting android screen mirror..."
  java -jar /root/asm.jar $ANDROID_HOME
fi
