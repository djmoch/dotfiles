#!/bin/sh
echo "Beginning sync on `date`"
xsession_pid=`cat $HOME/.xsession.pid`

if ps -U $LOGNAME -o pid= | grep $xsession_pid > /dev/null 2>&1 && type vdirsyncer > /dev/null 2>&1
then
    export DISPLAY=`cat $HOME/.xdisplay`
    vdirsyncer sync
    unset DISPLAY
else
    echo "No X session running. Aborting"
fi

echo "Completed sync on `date`"
