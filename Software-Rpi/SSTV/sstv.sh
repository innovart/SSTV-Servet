#!/bin/bash 
#
# This is SSTV beacon transmissions for ETOPIA launch ballon
# 
# 11/2017 - Jorge Mata
#
export SSTVDIR=/home/pi/SSTV
cd $SSTVDIR

# Set some variables
GPIO_PTT=4
#GPIO_PWR=11
DEBUG=1

# Initalize the GPIO ports 
#/usr/local/bin/gpio mode $GPIO_PWR out
/usr/local/bin/gpio mode $GPIO_PTT out 

/usr/local/bin/gpio write $GPIO_PTT 0
sleep 1
/usr/local/bin/gpio write $GPIO_PTT 0

frecuency=$(python set_frecuency.py)

printf $frecuency

# Set volume
amixer sset PCM 100%

sudo modprobe bcm2835-v4l2

############
###BMP180###
############

altitude=$(python altitude.py)

printf $altitude

temp=$(python temp.py)

printf $temp

####################################
### Do image capture from webcam ###
####################################
# capture image and save
/usr/bin/fswebcam  --jpeg 95 --skip 2 -F 2 --deinterlace  --banner-colour "#10000000" --shadow --title "SERVETII  EA2ACZ" --subtitle "ALT: "$altitude --info "TEMP: "$temp --crop 320x240  -d v4l2:/dev/video0 --save ${SSTVDIR}/webcam.jpg
/usr/bin/fswebcam  --no-banner --resolution 2592x1944 --png 0  -d v4l2:/dev/video0 ${SSTVDIR}/webcam2.png

# Run program to encode webcam.jpg to webcam.wav audio file
${SSTVDIR}/robot36


#########################
### SWITCH ON WALKIE  ###
#########################
# PWR ON
#/usr/local/bin/gpio write $GPIO_PWR 1 
#sleep 3
# PTT ON
/usr/local/bin/gpio write $GPIO_PTT 1 
#sleep .25


#
# Transmit SSTV Image
#
/usr/bin/aplay -d 0  ${SSTVDIR}/webcam.wav

#########################
/usr/local/bin/gpio mode $GPIO_PTT out 
/usr/local/bin/gpio write $GPIO_PTT 0
sleep 1
/usr/local/bin/gpio write $GPIO_PTT 0
### SWITCH OFF WALKIE ###
#########################
sleep 170


#######################
### Move and Rename ###
#######################
 newname=$(date +%Y%m%d_%H%M)
 mv ${SSTVDIR}/webcam.jpg ${SSTVDIR}/pictures/lowres/$newname.jpg
 mv ${SSTVDIR}/webcam2.png ${SSTVDIR}/pictures/highres/$newname.png
 rm -f ${SSTVDIR}/webcam.jpg
 rm -f ${SSTVDIR}/webcam2.png

 rm -f ${SSTVDIR}/webcam.wav

#######################
### Relaunch System ###
#######################

./sstv.sh
