#! /usr/bin/python
import serial
import json
from time import sleep
bluetoothSerial = serial.Serial( "/dev/rfcomm0", baudrate=9600 )
# On envoie la commande de recuperation de temperature et humidite
with open ('datacapt.txt','w') as file:
    bluetoothSerial.write(b'\x00')
    list_str=bluetoothSerial.readline().decode()
    list_str=list_str.replace("\r\n","")
    file.write(list_str)
    #print (bluetoothSerial.read(2))

