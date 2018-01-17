#!/bin/sh
#
# ~/.xsession
#

[ -n "$DISPLAY" ] && echo "$DISPLAY" > "$HOME/.xdisplay"

xset dpms 0 0 300

if [ -d /usr/share/fonts/noto/ ]
then
    xset fp+ /usr/share/fonts/noto/
    xset fp rehash
fi

if type dex > /dev/null 2>&1
then
    : ${XDG_CURRENT_DESKTOP:=$XDG_SESSION_DESKTOP}
    case $XDG_CURRENT_DESKTOP in
        awesome|twm)
            dex -ae $XDG_CURRENT_DESKTOP
            ;;
    esac
fi
