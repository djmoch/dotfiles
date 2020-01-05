if logname > /dev/null 2>&1
then
	LOGNAME=$(logname)
else
	LOGNAME=$(basename $HOME)
fi
export LOGNAME
