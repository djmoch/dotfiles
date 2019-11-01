__ps1() {
	last=$?
	[ $last -ne 0 ] && echo -n "[$last] "
	echo -n $LOGNAME@$HOSTNAME:
	if [ "$PWD" = "$HOME" ]
	then
		echo -n '~'
	else
		echo -n $(basename "$PWD")
	fi

	if type git > /dev/null 2>&1
	then
		if git rev-parse --show-toplevel > /dev/null 2>&1
		then
			gitref=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
			[ $? -ne 0 ] && gitref="GIT: empty"
			[ "$gitref" = HEAD ] && gitref=\($(git rev-parse --short HEAD)\)
			git diff --no-ext-diff --quiet || status="*"
			git diff --no-ext-diff --cached --quiet || status="$status+"
			if [ "$(git config --bool sh.showUntrackedFiles)" != "false" ] &&
				git ls-files --others --exclude-standard --directory \
				--no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
			then
				status="$status%"
			fi
			[ -n "$status" ] && gitref="$gitref $status"
			echo " ($gitref)"
		else
			echo
		fi
	fi
}
PS1='$(__ps1)\$ '
export PS1
