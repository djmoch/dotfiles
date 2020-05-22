if [ "$termprog" = "9term" -o "$termprog" = "win" ]
then
	cd() {
		[ -z "$1" ] && set -- "$HOME"
		command cd "$1" && awd $HOSTNAME
	}
	awd $HOSTNAME
fi
