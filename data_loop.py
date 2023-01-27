import RPi.GPIO as GPIO 
import time 

pir_gpio = 23 
GPIO.setmode(GPIO.BCM) 
GPIO.setup(pir_gpio,GPIO.IN)

if (GPIO.input(pir_gpio)==0):
	print(False)
elif(GPIO.input(pir_gpio)==1):
	print(True)
