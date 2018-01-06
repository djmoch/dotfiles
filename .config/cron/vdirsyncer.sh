#!/bin/sh
echo "Beginning sync on `date`"
vdirsyncer sync
echo "Completed sync on `date`"
