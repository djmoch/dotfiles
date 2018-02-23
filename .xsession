#!/bin/sh
#
# ~/.xsession
#
echo "Running $HOME/.xsession as PID $$" >&2
date +'%m/%d/%Y %H:%M:%S' >&2
env >&2
[ -r "$HOME/.xsession.local" ] && . "$HOME/.xsession.local"

__autostart()
{
    if type dex > /dev/null 2>&1
    then
        AUTOSTART_CMD="dex -ae $1"
    elif type fbautostart > /dev/null 2>&1
    then
        FBXDG_DE=$1
        AUTOSTART_CMD="fbautostart"
    fi

    until ps -u $LOGNAME -U $LOGNAME | grep $1 > /dev/null 2>&1
    do
        sleep 1
    done

    if [ -n "$AUTOSTART_CMD" ]
    then
        echo "Running autostart command: $AUTOSTART_CMD" >&2
        $AUTOSTART_CMD >&2
    else
        xbindkeys >&2
    fi
}

xset dpms 0 0 900 s 300 0 s blank s noexpose s on
[ -r "$HOME/.Xmouse" ] && xmodmap .Xmouse

SHLVL=0; export SHLVL

my kbopts
my screen

if [ $# -eq 0 ]
then
    for wm in awesome i3 startxfce4 twm cinnamon-session
    do
        if type $wm > /dev/null 2>&1
        then
            echo "Setting window manager to $wm" >&2
            set -- $wm
            break
        fi
    done
fi

case $1 in
    start*|*session) ;;
    *)
        __autostart "$@" &
        ;;
esac

unset __autostart
exec "$@"
