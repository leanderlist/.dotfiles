#!/bin/bash

t=0
sleep_pid=0

weekday_en=$(date "+%A")
month_en=$(date "+%B")

toggle() {
	t=$(((t+1)%2))

	if [ "$sleep_pid" -ne 0 ]; then
		kill $sleep_pid >/dev/null 2>&1
	fi
}

if [ "$month_en" == "January" ]; then
	month_de="Januar"
elif [ "$month_en" == "February" ]; then
	month_de="Februar"
elif [ "$month_en" == "March" ]; then
	month_de="März"
elif [ "$month_en" == "May" ]; then
	month_de="Mai"
elif [ "$month_en" == "June" ]; then
	month_de="Juni"
elif [ "$month_en" == "July" ]; then
	month_de="Juli"
elif [ "$month_en" == "October" ]; then
	month_de="Oktober"
elif [ "$month_en" == "December" ]; then
	month_de="Dezember"
else 
	month_de="$month_en"
fi

if [ "$weekday_en" == "Monday" ]; then
		weekday_de="Montag"
elif [ "$weekday_en" == "Tuesday" ]; then
		weekday_de="Dienstag"
elif [ "$weekday_en" == "Wednesday" ]; then
		weekday_de="Mittwoch"
elif [ "$weekday_en" == "Thursday" ]; then
		weekday_de="Donnerstag"
elif [ "$weekday_en" == "Friday" ]; then
		weekday_de="Freitag"
elif [ "$weekday_en" == "Saturday" ]; then
		weekday_de="Samstag"
elif [ "$weekday_en" == "Sunday" ]; then
		weekday_de="Sonntag"
fi

output=$(date "+%d. $month_de %Y")", "$weekday_de

trap "toggle" USR1

while true; do
	if [ $t -eq 0 ]; then
		echo $(date "+%H:%M")
	else
		echo $output
	fi
	sleep 1
	sleep_pid=$!
	wait
done
