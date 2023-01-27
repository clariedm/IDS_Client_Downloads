#! /usr/bin/python
import serial
import json
import time

bluetoothSerial = serial.Serial( "/dev/rfcomm0", baudrate=9600 )
# On envoie la commande de recuperation de temperature et humidite

bluetoothSerial.write(b'\x00')
list_str=bluetoothSerial.readline().decode()
list_str=list_str.replace("\r\n","")
print(list_str)


