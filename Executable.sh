#!/bin/bash
echo Updating ...
sudo apt-get update
sudo apt-get -y upgrade
echo Installing bluetooth command package ...
sudo apt-get -y install bluetooth pi-bluetooth blueman
echo Removing legacy nodejs and installing the latest version ...
sudo apt-get remove nodejs nodejs-legacy -y
sudo apt-get nodejs -y
echo Installing NodeRed ...
sudo apt install build-essential git curl
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
echo Installing NodeRed packages ...
cd
cd .node-red
npm i node-red-dashboard
npm i node-red-node-ui-table
npm install node-red-contrib-pythonshell
npm install node-red-contrib-simpletime
npm install node-red-node-openweathermap
npm install node-red-contrib-ui-svg
echo Moving files downloaded from github ...
cd
sudo mv -v /home/pi/Desktop/IDS_Client_Downloads /home/pi/bin
chmod 755 /home/pi/bin/reconnectionBluetooth.sh # Changes access permissions for the shell script that manages the bluetooth reconnection after reboot
echo All done ! Rebooting in 10 seconds ...
sleep 10
sudo reboot
