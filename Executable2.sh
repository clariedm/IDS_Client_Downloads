#!/bin/bash
echo Setting wallpaper ...
pcmanfm --set-wallpaper /bin/Wallpaper.png
echo Defining reboot parameters ...
cd .config
sudo mkdir -p lxsession/LXDE-pi
cd 
mv /bin/autostart /.config/lxsession/LXDE-pi/autostart
echo All done ! Rebooting in 10 seconds.
sleep 10
sudo reboot