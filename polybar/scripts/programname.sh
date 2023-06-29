#!/bin/bash

window_id=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}')

if [ "$window_id" != "0x0" ]; then
	window_title=$(xprop -id "$window_id" WM_CLASS | awk -F '"' '{print $4}' | awk '{for(i=1;i<=NF;i++)sub(".",substr(toupper($i),1,1),$i)}1')

	if [ ! -z "$window_title" ]; then
		if [ "$window_title" == "Alacritty" ]; then
			echo " $window_title"
		elif [ "$window_title" == "Kitty" ]; then
			echo " $window_title"
		elif [ "$window_title" == "Firefox" ]; then
			echo " $window_title"
		elif [ "$window_title" == "Bitwarden" ]; then
			echo " $window_title"
		elif [ "$window_title" == "Org.gnome.Nautilus" ]; then
			echo " Nautilus"
		elif [ "$window_title" == "VSCodium" ]; then
			echo "󰨞 $window_title"
		else
			echo " $window_title"
		fi
	fi
else
	echo ""
fi
