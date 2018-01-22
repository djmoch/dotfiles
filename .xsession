#!/bin/sh
#
# ~/.xsession
#
[ -n "$DISPLAY" ] && echo "$DISPLAY" > "$HOME/.xdisplay"
[ -f "$HOME/.xdisplay" ] && chmod 600 "$HOME/.xdisplay"

__autostart()
{
    : ${XDG_CURRENT_DESKTOP:=${XDG_SESSION_DESKTOP:-$1}}
    if type dex > /dev/null 2>&1
    then
        AUTOSTART_CMD="dex -ae $XDG_CURRENT_DESKTOP"
    elif type fbautostart > /dev/null 2>&1
    then
        AUTOSTART_CMD="fbautostart"
    fi

    until ps -u $LOGNAME -U $LOGNAME | grep $1 > /dev/null 2>&1
    do
        sleep 1
    done

    case $XDG_CURRENT_DESKTOP in
        awesome|i3|twm)
            if [ -n "$AUTOSTART_CMD" ]
            then
                $AUTOSTART_CMD
            else
                xbindkeys
            fi
            ;;
    esac
}

xset dpms 0 0 300
[ -r "$HOME/.Xmouse" ] && xmodmap .Xmouse

SHLVL=0; export SHLVL

my kbopts
my screen

if [ -d /usr/share/fonts/noto/ ]
then
    xset fp+ /usr/share/fonts/noto/
    xset fp rehash
fi

if [ $# -eq 0 ]
then
    for wm in awesome startxfce4 i3 twm cinnamon-session
    do
        >&2 echo "No params provided. Setting window manager."
        if type $wm > /dev/null 2>&1
        then
            set -- $wm
            EXEC=1
            break
        fi
    done
fi

if [ "$1" = "twm" ]
then
    set -- xterm
    twm &
fi

__autostart "$@" &

unset __autostart
[ -n $EXEC ] && exec "$@"
