#!/bin/sh
#
# ~/.xsession
#
[ -r "$HOME/.xsession.local" ] && . "$HOME/.xsession.local"
[ -n "$DISPLAY" ] && echo "$DISPLAY" > "$HOME/.xdisplay"
[ -f "$HOME/.xdisplay" ] && chmod 600 "$HOME/.xdisplay"

__autostart()
{
    if type dex > /dev/null 2>&1
    then
        AUTOSTART_CMD="dex -ae $1"
    elif type fbautostart > /dev/null 2>&1
    then
        AUTOSTART_CMD="FBXDG_DE=$1 fbautostart"
    fi

    until ps -u $LOGNAME -U $LOGNAME | grep $1 > /dev/null 2>&1
    do
        sleep 1
    done

    if [ -n "$AUTOSTART_CMD" ]
    then
        $AUTOSTART_CMD
    else
        xbindkeys
    fi
}

xset dpms 0 0 300
[ -r "$HOME/.Xmouse" ] && xmodmap .Xmouse

SHLVL=0; export SHLVL

my kbopts
my screen

if [ $# -eq 0 ]
then
    for wm in awesome i3 startxfce4 cinnamon-session twm
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

case $1 in
    awesome|i3|twm)
        __autostart "$@" &
        ;;
esac

unset __autostart
exec "$@"
