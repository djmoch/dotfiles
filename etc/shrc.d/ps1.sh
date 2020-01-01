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
		workdir=$(git rev-parse --is-inside-work-tree 2>/dev/null)
		if [ $? -eq 0 ]
		then
			if [ "$workdir" = "false" ]
			then
				bare=$(git rev-parse --is-bare-repository 2>/dev/null)
				if [ $? -ne 0 ]
				then
					echo
				else
					echo " (GIT: bare)"
				fi
			else
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
			fi
		else
			echo
		fi
	fi
}
PS1='$(__ps1)\$ '
export PS1
