#!/bin/bash

curr_string=$(brillo)
curr=${curr_string%%.*}

if [ $curr -gt 74 ]; then
	output="󰃠 $curr"
elif [ $curr -gt 24 ] && [ $curr -lt 75 ]; then
	output="󰃟 $curr"
elif [ $curr -gt 0 ] && [ $curr -lt 25 ]; then
	output="󰃞 $curr"
fi
echo $output
