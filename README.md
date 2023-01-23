# IDS_Client_Downloads
## Organization
You will find all the files necessary to configure the client Raspberry Pis here.
All of them except “Executable.sh” will be downloaded automatically as you run the installation programs.

## Configuring the client Raspberry Pis - Part 1
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

## Configuring the client Raspberry Pis - Part 2
Once the Raspberry Pi has rebooted you will want to execute the following command line in your terminal:
```
node-red status
```
This will return information about the address at which node-red is running. The information will be shown as follows:
________________________
The address is ________________________

# Case 1: The address is 127.0.0.1
If the adress is 127.0.0.1 then you can run a second file using the following command line in your terminal:
```
bash Executable2.sh
```

# Case 2: The address is not 127.0.0.1
If the address is not 127.0.0.1 then you will need to make a few modifications before you can run the second file. 
The modifications are as follows:
1. Go into the autostart file and change the following line:
```
_______
```
to the following:
```
_____
```
2. Go into the openchromium2.sh file and change the following line:
```
_______
```
to the following:
```
_____
```
3. Now run the second file using the following commands:
```
cd
bash Executable2.sh
```
