# IDS_Client_Downloads
## Organization
You will find all the files necessary to configure the client Raspberry Pis here.
All of them except will be downloaded automatically when you run the first command lines.

## Files:
| Name | Function |
| :---: | --- |
| autostart | shell script setting reboot parameters for the Raspberry Pi|
| Chargement.gif | gif used as a loading screen as NodeRed can take some time to start after reboot |
| chromiumManager.py | a python script
| desktop-items-0.conf | shell script setting desktop parameters for the Raspberry Pi |
| Executable.sh | shell script containing a first set of commands implementing the changes to be made in the Raspberry Pi configuration, before NodeRed is deployed |
| Executable2.sh | shell script executing a second set of commands implementing the changes to be made in the Raspberry Pi configuration,  after NodeRed is deployed |
| openchromium.sh | shell script containing a first set of command to be executed every time the Raspberry Pi reboots |
| openchromium2.sh | shell script containing a second set of command to be executed every time the Raspberry Pi reboots |
| README_ENGLISH.md | this file, containing all the information necessary to configure the client Raspberry Pi and download the necessary files |
| README_FRENCH.md | this file, but in french |
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
______

When the file is done executing the Raspberry Pi will reboot.

# Part 2: NodeRed
Once the Raspberry Pi has rebooted you will want to execute the following command line in your terminal:
```
ifconfig
```
This will return information about the address at which node-red is running in the midst of other information. You will find the address under "lo:" , as follows:
```
lo: flags=73<UP,LOOPBACK,RUNNING> mtu65536
      inet [ADDRESS]  netmask 255.0.0.0
      inet6::1  prefixlen 128 scopeid 0x10<host>
```
The address will be where ```[ADDRESS]``` is shown in this example.

After that, open Chromium through the graphic user interface and go to the address. When NodeRed opens you should be able to see an import button. You should use it to import the json file that you will find in the bin folder in the file navigtor. 

After you've imported the file, click on deploy and close the window. You should be able to see the NodeRed interface running in your browser at [ADDRESS]:1880/ui . 

# Part 3: Checking the localhost address for NodeRed

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

# Part 3: Setting up the Bluetooth connection

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

# Part 5:

Now run the second file using the following commands:
```
cd
cd /home/pi/bin
bash Executable2.sh
```
