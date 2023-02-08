#!/bin/bash
echo Defining reboot parameters ...
cd
cd /home/pi/.config
sudo mkdir -p lxsession/LXDE-pi # Creates the directories where the autostart file will be stored
sudo mkdir -p pcmanfm/LXDE-pi # Creates the directories where the pcmanfm profile files will be stored
sudo mv /home/pi/bin/desktop-items-0.conf /home/pi/.config/pcmanfm/LXDE-pi/
cd 
sudo mv /home/pi/bin/autostart /home/pi/.config/lxsession/LXDE-pi/autostart # Moves the autostart file from bin to the newly created directories
echo Setting wallpaper ...
pcmanfm --set-wallpaper /home/pi/bin/Wallpaper.png 
echo All done ! Rebooting in 10 seconds.
sleep 10
sudo reboot
