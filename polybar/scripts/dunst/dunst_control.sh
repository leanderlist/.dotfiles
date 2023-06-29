#!/bin/bash

is_paused=$(dunstctl is-paused)

if [ "$is_paused" == "true" ]; then
	dunstctl close-all
	dunstctl set-paused false
elif [ "$is_paused" == "false" ]; then
	dunstctl close-all
	dunstctl set-paused true
fi
