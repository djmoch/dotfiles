#!/bin/sh
echo "Beginning sync on `date`"
export DISPLAY=`cat $HOME/.xdisplay`
vdirsyncer sync
unset DISPLAY
echo "Completed sync on `date`"
