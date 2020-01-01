if [ ! -f "$HOME/.hushlogin" ]
then
	if [ -r /etc/motd -a -n "$DISPLAY" -a -z "$SSH_TTY" ]
	then
		[ $SHLVL -le 1 ] && cat /etc/motd
	fi
fi
