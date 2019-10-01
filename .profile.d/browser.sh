if type w3m > /dev/null 2>&1
then
	BROWSER=w3m
	WWW_HOME=https://www.danielmoch.com; export WWW_HOME
elif type lynx > /dev/null 2>&1
then
	BROWSER=lynx
fi
export BROWSER
