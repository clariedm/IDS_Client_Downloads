#!/usr/bin/env python3

# This file must have the path ~/bin/screenManager.py

# Add this line on ~/.config/lxsession/LXDE-pi/autostart to make it run on boot and on background :
# @python3 /home/pi/bin/screenManager.py

# This script turns on and off the monitor connected to a Raspberry Pi. It turns
# it on every day at 8:00 except during the weekends. It turns it off at 21:00.

import datetime
import subprocess
import time

def monitor_should_be_on():

    now = datetime.datetime.now()

    # At 8:00 turn screen on
    if now.hour >= 8:
        # At 21:00 turn screen off
        if now.hour < 21:
            # Only Monday to Friday
            if now.isoweekday() < 6:
                return True

    return False

def monitor_turn_on():

    subprocess.call('export DISPLAY=":0"\n' +
                    # Turn monitor on
                    'xset dpms force on\n' +
                    # Disable functions that turn screen off 
                    'xset s noblank\n' +
                    'xset set off\n' +
                    'xset -dmps\n', shell=True)
    return

def monitor_turn_off():

    subprocess.call(# Enable functions that turn screen off
                    'xset s on\n' + 
                    'xset +dpms\n' +
                    'xset s blank\n' +
                    'export DISPLAY=":0"\n' +
                    # Turn monitor off
                    'xset dpms force off', shell=True)
    return


# On boot screen is ON
last_state = True
monitor_turn_on()

# Loop forever
while True:

    new_state = monitor_should_be_on()

    # We just need to use the command to turn on or off screen if the desired state is different from the last one
    # Otherwise the current state is already the desired one
    if new_state != last_state :
        if new_state:
            monitor_turn_on()
   	 last_state = new_state

    if not new_state:
            monitor_turn_off()

    # Sleep for 1 minute
    time.sleep(60)

# The loop was made because there are other ways to turn on (simply touching the screen) 
# and turn off (by command line) the screen. With this code, that must run on background
# we want to make sure that the screen will have the right state during the whole day.
