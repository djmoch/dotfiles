#!/bin/sh

expected="eDP-1 DP-1-3"

for mon in $expected
do
	if xrandr -q | grep $mon | grep ' connected' >/dev/null 2>&1
	then
		connected="$connected $mon"
	else
		disconnected="$disconnected $mon"
	fi
done

cmd="xrandr --dpi eDP-1"

for mon in $connected
do
	if [ "$mon" = "eDP-1" ]
	then
		cmd="$cmd --output eDP-1 --auto --primary"
	elif [ "$mon" = "DP-1-3" ]
	then
		cmd="$cmd --output DP-1-3 --auto --right-of eDP-1 --scale 2x2"
	fi
done

for mon in $disconnected
do
	cmd="$cmd --output $mon --off"
done

echo "my-screen.local: Running cmd $cmd" >> "$HOME/var/log/my"
$cmd
if [ "$1" != "rio" ]
then
	my wallpaper
fi
