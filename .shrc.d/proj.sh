proj() {
	if [ -d "$HOME/Documents/src/$1" ]
	then
		cd "$HOME/Documents/src/$1"
		[ -f .env ] && . ./.env
	fi
}
