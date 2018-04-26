import Adafruit_BMP.BMP085 as BMP085

sensor= BMP085.BMP085()

altitude = sensor.read_altitude()
altitude=int(altitude)
print(altitude)
