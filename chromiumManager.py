#!/usr/bin/env python3

# This file must have the path ~/bin/chromiumManager.py

# Add this line on ~/.config/lxsession/LXDE-pi/autostart to make it run on boot and on background :
# @python3 /home/pi/bin/chromiumManager.py

# Closes browser while school is closed and restarts it when school opens again


import datetime
import subprocess
import time

def chromium_should_be_on():
    now = datetime.datetime.now()

    # At 8:00 turn screen on
    if now.hour >= 8:
        # At 21:00 turn screen off
        if now.hour < 21:
            # Only Monday to Friday
            if now.isoweekday() < 6:
                return True

    return False

def chromium_start():
    subprocess.call('chromium-browser --start-fullscreen --start-maximized http://127.0.0.1:1880/ui', shell=True)
    return

def chromium_stop():
    subprocess.call('killall chromium-browser', shell=True)
    return

# NodeRed starts on reboot so its first state after reboot is always ON
last_state = True

while True:
    new_state = chromium_should_be_on()

    # We just need to use the command to start or stop node red if the desired state is different from the last one
    # Otherwise the current state is already the desired one
    if new_state != last_state:
        if chromium_should_be_on():
            chromium_start()
        else:
            chromium_stop()
        last_state = new_state

    #Sleep for 1 minute
    time.sleep(60)
