#!/bin/sh
#
# ~/.xsession
#

[ -n "$DISPLAY" ] && echo "$DISPLAY" > "$HOME/.xdisplay"
[ -f "$HOME/.xdisplay" ] && chmod 600 "$HOME/.xdisplay"

xset dpms 0 0 300
[ -r "$HOME/.Xmouse" ] && xmodmap .Xmouse

SHLVL=0; export SHLVL

xsetroot -solid "#444444"
[ -x "$HOME/.fehbg" ] && "$HOME/.fehbg"

if [ -d /usr/share/fonts/noto/ ]
then
    xset fp+ /usr/share/fonts/noto/
    xset fp rehash
fi

if [ $# -eq 0 ]
then
    for wm in awesome i3 startxfce4 cinnamon-session twm
    do
        if type $wm > /dev/null 2>&1
        then
            set -- $wm
            EXEC=1
            break
        fi
    done
fi

if type dex > /dev/null 2>&1
then
    AUTOSTART_CMD='dex -ae $XDG_CURRENT_DESKTOP'
elif type fbautostart > /dev/null 2>&1
then
    AUTOSTART_CMD="fbautostart"
fi

if [ -n "$AUTOSTART_CMD" ]
then
    : ${XDG_CURRENT_DESKTOP:=${XDG_SESSION_DESKTOP:-$1}}
    case $XDG_CURRENT_DESKTOP in
        awesome|i3|twm)
            $AUTOSTART_CMD
            ;;
    esac
    
    if [ "$XDG_CURRENT_DESKTOP" = "twm" ]
    then
        set -- xterm
        twm &
    fi
fi

[ -n $EXEC ] && exec $@
