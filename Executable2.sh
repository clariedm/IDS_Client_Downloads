#!/bin/bash
echo Setting wallpaper ...
pcmanfm --set-wallpaper /bin/Wallpaper.png
echo Defining reboot parameters ...
cd
cd /home/pi/.config
sudo mkdir -p lxsession/LXDE-pi
cd 
mv bin/autostart /home/pi/.config/lxsession/LXDE-pi/autostart
echo All done ! Rebooting in 10 seconds.
sleep 10
sudo reboot
