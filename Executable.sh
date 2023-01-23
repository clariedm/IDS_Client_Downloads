#!/bin/bash
echo Updating ...
sudo apt-get update
sudo apt-get upgrade
echo Installing nodejs and npm ...
sudo apt-get install -y nodejs
echo Installing NodeRed ...
sudo apt install build-essential git curl
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
echo Configuring NodeRed ...
sudo npm install -g pm2
pm2 start /usr/bin/node-red --node-args="--max-old-space-size=128" -- -v
pm2 save
pm2 startup systemd
echo Configuring reboot parameters ...
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u pi --hp /home/pi
echo Installing NodeRed packages ...
cd
cd .node-red
npm i node-red-dashboard
npm i node-red-node-ui-table
Downloading files from github ...
sudo mkdir bin
cd bin
curl -LJO https://github.com/philibertsalmon/ids_oasis/blob/master/installations_clients/Chargement.gif
curl -LJO https://github.com/philibertsalmon/ids_oasis/blob/master/installations_clients/Wallpaper.png
curl -LJO https://github.com/philibertsalmon/ids_oasis/blob/master/installations_clients/autostart
curl -LJO https://github.com/philibertsalmon/ids_oasis/blob/master/installations_clients/openchromium.sh
curl -LJO https://github.com/philibertsalmon/ids_oasis/blob/master/installations_clients/openchromium2.sh
curl -LJO https://github.com/philibertsalmon/ids_oasis/blob/master/installations_clients/Executable2.sh
echo All done ! Rebooting in 10 seconds.
sleep 10
sudo reboot