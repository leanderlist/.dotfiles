#!/bin/bash

status=$(cat /sys/class/power_supply/BAT0/status)
capacity=$(cat /sys/class/power_supply/BAT0/capacity)

if [ $capacity -gt 74 ]; then
	if [ "$status" == "Charging" ]; then
		output="󱊦 $capacity%"
	else 
		output="󱊣 $capacity%"
	fi

elif [ $capacity -lt 75 ] && [ $capacity -gt 29 ]; then
	if [ "$status" == "Charging" ];then
		output="󱊥 $capacity%"
	else
		output="󱊢 $capacity%"
	fi
	
elif [ $capacity -gt 9 ] && [ $capacity -lt 30 ]; then
	if [ "$status" == "Charging" ]; then
		output="󱊤 $capacity%"
	else 
		output="󱊡 $capacity%"
	fi
elif [ $capacity -lt 10 ]; then
	if [ "$status" == "Charging" ]; then
		output="󰢟 $capacity%"
	else
		output="󰂎 $capacity%"
	fi
fi

echo $output
