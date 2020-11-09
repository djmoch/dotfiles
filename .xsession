#!/bin/sh
echo "Running $HOME/.xsession as PID $$" >&2
[ -r "$HOME/.Xresources.local" ] && xrdb -merge "$HOME/.Xresources.local"
date +'%m/%d/%Y %H:%M:%S' >&2
env >&2

xset dpms 0 0 900
setxkbmap -option -option ctrl:nocaps
screen.$HOSTNAME
xcompmgr &
plumber &
riostart &

exec rc -l rio
