#!/bin/bash
echo Defining reboot parameters ...
cd
cd /home/pi/.config
sudo mkdir -p lxsession/LXDE-pi
cd 
sudo mv /home/pi/bin/autostart /home/pi/.config/lxsession/LXDE-pi/autostart
cd
sudo rm /etc/xdg/pcmanfm/LXDE-pi/desktop-items-0.conf
sudo mv /home/pi/bin/desktop-items-0.conf /etc/xdg/pcmanfm/LXDE-pi/
echo Setting wallpaper ...
pcmanfm --set-wallpaper home/pi/bin/Wallpaper.png
echo All done ! Rebooting in 10 seconds.
sleep 10
sudo reboot
