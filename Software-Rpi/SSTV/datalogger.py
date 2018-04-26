import Adafruit_BMP.BMP085 as BMP085
import time
import csv

sensor = BMP085.BMP085()

while True: #infinite loop
    Temp = sensor.read_temperature()
    sea_level = sensor.read_altitude()
    curdttm = time.strftime("%m/%d/%Y %I:%M %p")
    with open('/home/pi/SSTV/data_log.csv','a') as csvfile:
      csvwriter = csv.writer(csvfile,delimiter=',',
      quotechar='|', quoting=csv.QUOTE_MINIMAL)
      csvwriter.writerow([curdttm,Temp,sea_level])
    time.sleep(60)



