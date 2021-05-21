#!/bin/sh

expected="eDP-1 DP-2-1 HDMI-1"

for mon in $expected
do
	if xrandr -q | grep $mon | grep ' connected' >/dev/null 2>&1
	then
		connected="$connected $mon"
	fi
done

if echo $connected | grep HDMI-1 >/dev/null 2>&1
then
	cmd="xrandr --dpi HDMI-1 --output HDMI-1 --auto --primary
		--output DP-2-1 --auto --right-of HDMI-1
		--output eDP-1 --off --output DP-2-2 --off"
else
	cmd="xrandr --dpi eDP-1 --output HDMI-1 --off
		--output DP-2-1 --off --output DP-2-2 --off
		--output eDP-1 --mode 1920x1080 --primary"
fi

if [ -z "$1" ]
then
	echo "my-screen.local: Running cmd $cmd" >> "$HOME/var/log/my"
	$cmd
elif [ "$1" = "-d" ]
then
	echo $cmd
else
	echo $(basename $0): unknown flag --- $1
	exit 1
fi
