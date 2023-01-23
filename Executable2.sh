#!/bin/bash
echo Setting wallpaper ...
pcmanfm --set-wallpaper home/pi/bin/Wallpaper.png
echo Defining reboot parameters ...
cd
cd /home/pi/.config
sudo mkdir -p lxsession/LXDE-pi
cd 
sudo mv /home/pi/bin/autostart /home/pi/.config/lxsession/LXDE-pi/autostart
echo All done ! Rebooting in 10 seconds.
sleep 10
sudo reboot
