#!/bin/bash

#TODO: have a `reconnect' argument that'll use the 



#Load the midi surface map
#cp ~/Desktop/Dropbox/sjh/Tightrope/scripts/bristolmidisurfaces/BME700 ~/.bristol/memory/profiles/BME700	

#LETS ASSUME WE DON'T NEED TO DO THIS AS IT EXISTS
#cp BME700mem/BME700 ~/.bristol/memory/profiles/BME700	

#Remove any existing memory files - that way we'll start with the default
rm -f ~/.bristol/memory/BME700/BME700*.mem

#	Behaviour is as follows
#	If there is no numbered file for the corresponding number on the BME700 mem console, then the default setting will be loaded
#	If a memory file with the right name is copied to the folder, BME700 will load it next time its number is selected
#	This means it's possible to load as many memories as you like without having to restart BME700
#	BUT: The mod console behavoir is unknown - need to research further how to control this.

for i in `seq 1 8`; 
do
	echo "installing memory location $i from presets"
	cp ../presets/BME700/BME700$i.mem ~/.bristol/memory/BME700/BME700$i.mem 
done
cp ../presets/BME700/BME700 ~/.bristol/memory/profiles/BME700
#Copy the midi mappings:

sleep 2



# THE FOLLOWING LINES ARE FOR BRISTOL VERSION 0.40.8-1 ON CYBULA LAPTOP
# Launch & connect Bristol BME700 
#             bme700  midi channel 2                named BME700, load memory file 5
#startBristol -bme700 -channel      2 -jack -midi seq -register BME700 -voices 3 -load 5  -gain 2&

# THE FOLLOWING LINES ARE FOR BRISTOL VERSION 0.40.8-1 ON DELL INSPIRON 1300 LAPTOP
#             bme700  midi channel 2                     named BME700, monophonic,memory file 5
startBristol -bme700 -channel      2 -jack -midi seq -register BME700 -voices 1 -load 5 -mono -lwf -gain 3&
sleep 4

# connect to jack - for live, we only want to connect to one channel
  jack_connect BME700:out_left system:playback_1
#  jack_connect BME700:out_right system:playback_2


#if `reconnect'

if [ "$1" = "reconnect" ]; then 
    echo "Reconnecting to seq24" 
    aconnect seq24:1 BME700:0
else
    echo "Not reconnecting to seq24"  
fi;










