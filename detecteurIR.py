from gpiozero import MotionSensor, LED
from signal import pause

pir = MotionSensor(4)
while True:
     pir.wait_for_motion()
     print("move")

