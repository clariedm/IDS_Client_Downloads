#!/bin/sh
sleep 30
sudo killall chromium-browser
chromium-browser --noerrdialogs --start-fullscreen --start-maximized 127.0.0.1:1880/ui
