if [ -n "$SSH_TTY" ]
then
	PS1="${HOSTNAME}\$(if [ \$(id -u) -ne 0 ]; then echo \$; else echo \#; fi) "
else
	PS1="\$(if [ \$(id -u) -ne 0 ]; then echo \$; else echo \#; fi) "
fi

export PS1
