#!/bin/sh
#
# ~/.xsession
#
echo "Running $HOME/.xsession as PID $$" >&2
[ -r "$HOME/.Xresources.local" ] && xrdb -merge "$HOME/.Xresources.local"
date +'%m/%d/%Y %H:%M:%S' >&2
env >&2

if [ $# -eq 0 ]
then
	for wm in $wm rio dwm awesome i3 twm
	do
		if type $wm > /dev/null 2>&1
		then
			echo "Setting window manager to $wm" >&2
			set -- $wm
			break
		fi
	done
fi

for file in "$HOME"/etc/xsession.d/*.sh
do
	[ -r $file ] && . $file
done

exec "$@"
