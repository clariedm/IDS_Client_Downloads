# IDS_Client_Downloads
## Organization
You will find all the files necessary to configure the client Raspberry Pis here.
All of them except will be downloaded automatically when you run the first command lines.

## Files:

### README files

| Name | Function |
| :---: | --- |
| README_ENGLISH.md | This file, containing all the information necessary to configure the client Raspberry Pi and download the necessary files |
| README_FRENCH.md | This file, but in french |

### Configuration files

| Name | Function |
| :---: | --- |
| autostart | Shell script setting reboot parameters for the Raspberry Pi |
| autostart_comments | autostart file but with comments: Caution !!! Should not be run
| Executable.sh | Shell script containing a first set of commands implementing the changes to be made in the Raspberry Pi configuration, before NodeRed is deployed |
| Executable2.sh | Shell script executing a second set of commands implementing the changes to be made in the Raspberry Pi configuration,  after NodeRed is deployed |
| openchromium.sh | Shell script containing a first set of command to be executed every time the Raspberry Pi reboots |
| openchromium2.sh | Shell script containing a second set of command to be executed every time the Raspberry Pi reboots |

### Sensors and Bluetooth connection

| Name | Function |
| :---: | --- |
| data_capteur.py | Python script for requesting and receiving humidity, temperature and CO2 sensor data from the Arduino Uno |
| data_loop.py | Python script that prints true if the PIR sensor detects motion or false if it doesn't |

### Energy Saving 

| Name | Function |
| :---: | --- |
| chromiumManager.py | Python script that closes chromium browser while school is closed and restarts it when school opens again |
| saveEnergy.sh | Shell script that turns off power output to LEDs and USB ports to save energy |
| screenManager.py | Python script that turns on and off the monitor connected to a Raspberry Pi. It turns it on every day at 8:00 except during the weekends. It turns it off at 21:00. |

### Interface
| Name | Function |
| :---: | --- |
| Interface.json | NodeRed interface |

### Graphical Charter

| Name | Function |
| :---: | --- |
| Chargement.gif | Gif used as a loading screen as NodeRed can take some time to start after reboot |
| Wallpaper.png | The wallpaper to be used in the newly configured Raspberry Pi |

## Configuring the client Raspberry Pis 
# Part 1 - Downloading updates and documents
First you will need to download “Executable.sh” onto your Desktop by executing the following command lines in your terminal: 
```
cd Desktop
git clone https://github.com/clariedm/IDS_Client_Downloads/
```
Now you will need to run the file by executing the following command lines in your terminal:
```
cd IDS_Client_Downloads
bash Executable.sh
```
As the file executes you will be asked to answer a few yes or no questions. You will want to answer yes to all of them except the following:
```
      Would you like to customize the settings now (y/N) ?
```

The installs could take up to 30 min. When the file is done executing the Raspberry Pi will reboot.

# Part 2: NodeRed
Once the Raspberry Pi has rebooted you will want to execute the following command line in your terminal:
```
node-red start
```
This will return information about the address at which node-red is running in the midst of other information. You will find the address as follows:
```
27 Jan 16:17:59 - [info] Server now running at https://[ADDRESS]
```
The address will be where ```[ADDRESS]``` is shown in this example. You should be able to see the NodeRed interface running in your browser at [ADDRESS]:1880/ui . 

# Part 3: Setting up NodeRed according to its localhost address

If the adress is 127.0.0.1 then you can move on to part 4.

If the address is not 127.0.0.1 then you will need to make a few modifications before you can run the second file. 
The modifications are as follows:

Change the following line in the openchromium2.sh file:
```
chromium-browser --start-fullscreen --start-maximized 127.0.0.1:1880/ui
```
to the following:
``` 
chromium-browser --start-fullscreen --start-maximized [NEW ADDRESS]:1880/ui
```

To do so you should use the following command line:
```
sudo nano /home/pi/bin/openchromium.sh
```

# Part 4: Setting up the Bluetooth connection

First, enter the following command lines into a shell window:

```
bluetoothctl
power on
agent on
scan on
```

After that you should get something like this: 

```
Discovery started
[CHG] Controller B8:27:EB:29:46:68 Discovering: yes
[NEW] Device 00:0E:EA:CF:22:8E 00-0E-EA-CF-22-8E
[CHG] Device 00:0E:EA:CF:22:8E LegacyPairing: no
[CHG] Device [DEVICE_ADDRESS] Name: HC-05
```
Look for the device with the name HC-05. It's address should be displayed as shown above, instead of [DEVICE_ADDRESS]. Using this address you will want to pair the device to the raspberry pi using the following command:

```
pair [DEVICE_ADDRESS]
```
This should output the following:
```
Attempting to pair with [DEVICE_ADDRESS]
[CHG] Device [DEVICE_ADDRESS] Connected: yes
Request PIN code
[agent] Enter PIN code: 
```
The PIN code is 1234.

After the device is paired, close the command window and open a new one. You will need to connect to the device using the following command line :
```
sudo rfcomm connect 0 [DEVICE_ADDRESS] &
```
To finish the Bluetooth configuration you will need to go into the reconnectionBluetooth.sh file and change 98:D3:51:FD:C8:BB to [DEVICE_ADDRESS] as follows :
```
#/bin/sh
sleep 20
sudo rfcomm connect 0 [DEVICE_ADDRESS] &
```

To do so, you can enter the following command line:

```
sudo nano /home/pi/bin/reconnectionBluetooth.sh
```

# Part 5: Final configurations and reboot

Now run the second file using the following commands:
```
cd
cd /home/pi/bin
bash Executable2.sh
```
