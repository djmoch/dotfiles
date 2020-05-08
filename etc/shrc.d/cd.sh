# The issue here is that Acme requires an additional call coupled
# with cd in order to update the window tag. We can use the value
# of $EDITOR to see if we're in an Acme environment.
if [ "$EDITOR" = "E" ]
then
	cd() {
		[ -z "$1" ] && set -- "$HOME"
		command cd "$1" && awd $HOSTNAME
	}
fi
