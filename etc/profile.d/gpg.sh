if [ -z "$SSH_TTY" ] && type gpgconf > /dev/null 2>&1
then
	if [ "`gpgconf --list-dirs agent-ssh-socket | wc -l`" -eq 1 ]
	then
		unset SSH_AGENT_PID
		SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`
		export SSH_AUTH_SOCK
	fi
fi
