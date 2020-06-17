if [ "$TERM" = "dumb" ]
then
	if type nobs >/dev/null 2>&1
	then
		PAGER=nobs
	else
		PAGER=cat
	fi
elif type less >/dev/null 2>&1
then
	PAGER=less
	LESS="-FMRqX#10"; export LESS
	if type lesspipe >/dev/null 2>&1
	then
		eval `lesspipe`
	else
		LESSOPEN="|$HOME/.lessfilter %s"
		export LESSOPEN
	fi
else
	PAGER=more
fi
export PAGER
