if type gpg-connect-agent > /dev/null 2>&1
then
	GPG_TTY=`tty`; export GPG_TTY
	gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
fi
