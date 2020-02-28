if type vise >/dev/null 2>&1
then
	VISUAL=vise
elif type vis >/dev/null 2>&1
then
	VISUAL=vis
else
	VISUAL=vi
fi
export VISUAL
