#!/bin/sh
echo "Running $HOME/.xsession as PID $$" >&2
xrdb "$XDG_CONFIG_HOME/Xresources"
[ -r "$XDG_CONFIG_HOME/Xresources.local" ] && xrdb -merge "$XDG_CONFIG_HOME/Xresources.local"
date +'%m/%d/%Y %H:%M:%S' >&2
env >&2

xset dpms 0 0 900
xset s 300
xinput set-prop "Synaptics TM3289-021" "libinput Natural Scrolling Enabled" 1
xinput set-prop "Synaptics TM3289-021" "libinput Click Method Enabled" 0 1
xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Button Scrolling Button" 0
xsidle.sh slock &
mpd &
picom &

autorandr -c --default default

exec dwmstart
