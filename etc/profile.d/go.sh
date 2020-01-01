if type go > /dev/null 2>&1
then
	GOPATH="$HOME/src/go"
	export GOPATH
	__addpath "$HOME/src/go/bin"
fi
