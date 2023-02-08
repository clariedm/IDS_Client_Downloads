#!/bin/bash
echo Defining reboot parameters ...
cd
cd /home/pi/.config
sudo mkdir -p lxsession/LXDE-pi # Creates the directories where the autostart file will be stored
cd 
sudo mv /home/pi/bin/autostart /home/pi/.config/lxsession/LXDE-pi/autostart # Moves the autostart file from bin to the newly created directories
cd
sudo sed -i "s/^show_trash.*/show_trash=0" /etc/xdg/pcmanfm/LXDE-pi/desktop-items-0.conf
#sudo rm /etc/xdg/pcmanfm/LXDE-pi/desktop-items-0.conf # Deletes the existing desktop-items-0.conf file
#sudo mv /home/pi/bin/desktop-items-0.conf /etc/xdg/pcmanfm/LXDE-pi/ # Moves the downloaded desktop-items-0.conf file to replace it
#sudo rm /etc/xdg/pcmanfm/LXDE-pi/desktop-items-1.conf # Deletes the existing desktop-items-0.conf file
#sudo mv /home/pi/bin/desktop-items-1.conf /etc/xdg/pcmanfm/LXDE-pi/ # Moves the downloaded desktop-items-0.conf file to replace it
echo Setting wallpaper ...
pcmanfm --set-wallpaper /home/pi/bin/Wallpaper.png 
echo All done ! Rebooting in 10 seconds.
sleep 10
sudo reboot
