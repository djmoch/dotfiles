#!/bin/sh
#
# ~/.xsession
#

if [ -d /usr/share/fonts/noto/ ]
then
    xset fp+ /usr/share/fonts/noto/
    xset fp rehash
fi
