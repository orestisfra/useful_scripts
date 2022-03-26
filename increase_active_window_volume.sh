#!/usr/bin/bash

window=$(xdotool getactivewindow getwindowpid) #get active window pid 

tempvar=$(pactl list sink-inputs | #temporary variable with all items producing sound in format "Sink_Input_number" "pid" "Sink_Input_number" "pid" etc.
 while read -r line ; do
 echo $line | grep -oP '#\K[^$]+'
 echo $line | grep -oP 'application.process.id = "\K[^"]+'
 done |
 tr '\n' ' ')

array=($tempvar) #array containing all items in $tempvar

for (( i = 0; i < ${#array[*]}; i++ )); do #for all array ellements
        if [[ $window == ${array[$i]} ]]; then #compare the active window pid and the programs' pid that produce sound
                actual_array_number=$(($i-1)) #because of the nature of the array subtract 1 to find Sink_Input_number
                pactl set-sink-input-volume ${array[$actual_array_number]} +5% #toggle audio for that app on or off
                break #don't continue the loop just exit
        fi
done
