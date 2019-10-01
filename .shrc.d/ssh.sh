ssh() {
	$(which ssh) "$@"
	printf "\033]0;$LOGNAME@$HOSTNAME\007"
}
