if type go > /dev/null 2>&1
then
	GOPATH="$HOME/.go"
	export GOPATH
	__addpath "$HOME/.go/bin"
fi
