proj() {
	if [ -d "$HOME/src/$1" ]
	then
		cd "$HOME/src/$1"
		[ ! -r .env ] || . ./.env
	fi
}
