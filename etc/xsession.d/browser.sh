if type surf > /dev/null 2>&1
then
	BROWSER=surf
else
	BROWSER=firefox
fi
export BROWSER