import time
import serial

ser = serial.Serial('/dev/serial0', 9600)         # enable the serial port

ser.write('AT+DMOSETGROUP=1,144.5000,144.5000,0000,2,0000\r\n')
time.sleep(1)
print('144.500')
