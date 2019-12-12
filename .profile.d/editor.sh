if type sam > /dev/null 2>&1
then
	EDITOR='sam -d'
elif type ed > /dev/null 2>&1
then
	EDITOR=ed
else
	EDITOR=ex
fi
FCEDIT=$EDITOR
export EDITOR FCEDIT
