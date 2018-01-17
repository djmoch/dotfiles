#!/bin/sh
#
# ~/.xsession
#

[ -n "$DISPLAY" ] && echo "$DISPLAY" > "$HOME/.xdisplay"

if [ -d /usr/share/fonts/noto/ ]
then
    xset fp+ /usr/share/fonts/noto/
    xset fp rehash
fi
