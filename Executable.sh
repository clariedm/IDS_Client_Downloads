#!/bin/bash
echo Updating ...
sudo apt-get update
sudo apt-get upgrade
echo Installing bluetooth command package ...
sudo apt-get install bluetooth pi-bluetooth blueman
echo Removing legacy nodejs and installing the latest version ...
sudo apt-get remove nodejs nodejs-legacy -y
curl -L https://git.io/n-install | bash
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
echo Moving files downloaded from github ...
sudo mv -v Desktop/IDS_Client_Downloads /home/pi/bin
chmod 755 /home/pi/bin/reconnectionBluetooth.sh
echo All done ! Rebooting in 10 seconds.
sleep 10
sudo reboot
