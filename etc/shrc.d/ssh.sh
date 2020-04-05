ssh() {
	$(which ssh) "$@"
	case $TERM in
	xterm*|rxvt*|st*|tmux*) printf "\033]0;$LOGNAME@$HOSTNAME\007" ;;
	esac
}
