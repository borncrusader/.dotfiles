#!/bin/bash

# TODO: CLEANUP!!

usage()
{
	echo "usage : dual_setup.sh [options]"
	echo "  mac  - just the mac"
	echo "  home - home monitor"
	echo "  work - external monitor at work"
	echo "  auto - automatically set the resolution based on the display config"

    echo "  arch-x230-lvds - only laptop configuration for arch linux on x230"
    echo "  arch-x230-hdmi - only hdmi configuration for arch linux on x230"
    echo "  arch-x230-both-left - both screens on x230; laptop on left"
    echo "  arch-x230-both-right - both screens on x230; laptop on right"
    echo "  arch-x230-both-down - both screens on x230; laptop on down"
    echo "  arch-x230-toggle - toggle between 2 modes"

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
elif [ "$1" == "arch-x230-lvds" ]; then
    xrandr --output LVDS-1 --mode 1366x768
    xrandr --output HDMI-1 --off
    echo 'arch-x230-lvds' > /tmp/.dual-setup
elif [ "$1" == "arch-x230-hdmi" ]; then
    xrandr --output LVDS-1 --off
    xrandr --output HDMI-1 --mode 1920x1080
elif [ "$1" == "arch-x230-both-left" ]; then
    xrandr --output LVDS-1 --mode 1366x768 --left-of HDMI-1
    xrandr --output HDMI-1 --mode 1920x1080
elif [ "$1" == "arch-x230-both-right" ]; then
    xrandr --output LVDS-1 --mode 1366x768 --right-of HDMI-1
    xrandr --output HDMI-1 --mode 1920x1080
elif [ "$1" == "arch-x230-both-down" ]; then
    xrandr --output HDMI-1 --mode 1920x1080 --primary
    xrandr --output LVDS-1 --mode 1366x768 --below HDMI-1 --noprimary
    echo 'arch-x230-both-down' > /tmp/.dual-setup
elif [ "$1" == "arch-x230-toggle" ]; then
    if [ -e /tmp/.dual-setup ]; then
        if [ "$(cat /tmp/.dual-setup)" == "arch-x230-lvds" ]; then
            xrandr --output LVDS-1 --off
            $0 arch-x230-both-down
        else
            $0 arch-x230-lvds
        fi
    fi
elif [ "$1" == "off" ]; then
	xrandr --output Virtual1 --off
else
	usage
fi
