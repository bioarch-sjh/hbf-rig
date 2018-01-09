#!/bin/bash
#
# Author: Simon Hickinbotham (after Murray Saul)

# Start Jack audio server
echo "starting qjackctl"
/usr/bin/qjackctl -s & 
sleep 3

# bme700
echo ""
echo "starting bme700"
echo ""
. ./bme700.sh

# crumar roadrunner on channel 1
echo ""
echo "starting crumar roadrunner"
echo ""
. ./roadrunner.sh

# Launch and connect yoshimi
echo ""
echo "starting yoshimi"
echo ""
. ./yosh.sh

# Fzbx
# Launch ttymii (add -v for verbose output)
#echo ""
#echo "starting arduino drum machine"
#echo ""
ttymidi -s /dev/ttyUSB0 -b 38400 -n fzbx &

#touchosc - to control things on the fly:
. ./touchousc.sh



# Start the sequencer & load the playlist 
# (we have to switch directories to make the playlist work!)

echo ""
echo "starting seq24plus"
echo ""
cd ../set/
seq24plus -X set.pls &
cd ../run/
sleep 3

############################################################

#hook the synths up to seq24:
#aconnect seq24:0 Hydrogen:0
echo ""
echo "making ALSA connections"
echo ""
aconnect seq24:1 BME700:0
aconnect seq24:5 yoshimi-yg:0
aconnect seq24:6 roadrunner:0


#connect direct to the Kawai drum m/c
#aconnect seq24:0 USB2.0-MIDI:0
aconnect seq24:0 arduino:0


#connect to the Volca Keys:
aconnect seq24:15 'USB Midi':0

#connext system in to out





#aconnect seq24:6 roadrunner:0
# In Fullerfest config, I had pro52 alongside BME700 - but this gives too "fat" a sound
#aconnect seq24:4 pro52:0

# Launch vkeybd
#vkeybd --octave 8 --channel 3 --name vkb1 &


#now connect the USB midi devices (TODO: check what happens if they aren't connected)
#aconnect Hydrogen:1 'USB Midi':0 
aconnect seq24:0  'USB2.0-MIDI':0






