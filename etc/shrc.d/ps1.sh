uid=$(id -u)

if [ $uid -ne 0 ]
then
	PS1='$ '
else
	PS1='# '
fi

if [ -n "$SSH_TTY" ]
then
	PS1="$(hostname -s)$PS1"
fi
export PS1
