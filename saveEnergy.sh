#!/bin/sh

# This file must have the path ~/bin/saveEnergy.sh

# Add this line on ~/.config/lxsession/LXDE-pi/autostart to make it run on boot and on background :
# @bash /home/pi/bin/saveEnergy.sh

# Turn-off USB ports
echo '1-1' |sudo tee /sys/bus/usb/drivers/usb/unbind
# Turn-off LEDs
xset led off