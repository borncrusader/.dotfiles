#!/bin/bash

usage()
{
	echo "usage : dual_setup.sh [options]"
	echo "  mac  - just the mac"
	echo "  home - home monitor"
	echo "  work - external monitor at work"
	echo "  auto - automatically set the resolution based on the display config"
	echo "  off  - switch off external monitor"
}

if [ -z $1 ]; then
	usage
	exit
fi

if [ "$1" == "mac" ]; then
	xrandr --output Virtual1 --mode 1440x900
elif [ "$1" == "home" ]; then
	xrandr --newmode "1920x1080" 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
	xrandr --addmode Virtual1 "1920x1080"
	xrandr --output Virtual1 --mode 1920x1080
elif [ "$1" == "work" ]; then
	xrandr --output Virtual1 --mode 1680x1050
elif [ "$1" == "auto" ]; then
	ssh sanantha-mac.local system_profiler SPDisplaysDataType > /tmp/.macres
	ndis=`grep Resolution /tmp/.macres | wc -l`

	if [ $ndis -eq 2 ]; then
		# two monitors! TODO : choosing mac or work based on which display has the window
		if [ ! -z "`grep '1920 x 1080' /tmp/.macres`" ]; then
			$0 home
		elif [ ! -z "`grep '1680 x 1050' /tmp/.macres`" ]; then
			$0 work
		fi
	else
		$0 mac
	fi
elif [ "$1" == "off" ]; then
	xrandr --output Virtual1 --off
else
	usage
fi
