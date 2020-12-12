#!/bin/sh
echo "Running $HOME/.xsession as PID $$" >&2
xrdb "$XDG_CONFIG_HOME/Xresources"
[ -r "$XDG_CONFIG_HOME/Xresources.local" ] && xrdb -merge "$XDG_CONFIG_HOME/Xresources.local"
date +'%m/%d/%Y %H:%M:%S' >&2
env >&2

xset dpms 0 0 900
setxkbmap -option -option ctrl:nocaps
screen.$HOSTNAME
xcompmgr &
plumber &
riostart &

exec rio
