PATH="$PATH:$HOME/bin"; export PATH
HOSTNAME=$(hostname | cut -d. -f1); export HOSTNAME
ENV="$HOME/etc/shrc"; export ENV
LANG=en_US.UTF-8; export LANG
FCEDIT=$EDITOR; export FCEDIT
XDG_CONFIG_HOME="$HOME/etc"; export XDG_CONFIG_HOME
XDG_CACHE_HOME="$HOME/var/cache"; export XDG_CACHE_HOME
XDG_DATA_HOME="$HOME/var"; export XDG_DATA_HOME
PYTHONUSERBASE="$HOME"; export PYTHONUSERBASE
GOPATH="$HOME"; export GOPATH
TMPDIR="$HOME/tmp"; export TMPDIR

case $HOSTNAME in
	carbon)
		PLAN9=/usr/local/plan9; export PLAN9
		PATH="$PATH:$PLAN9/bin"; export PATH
		BROWSER=w3m; export BROWSER
		WWW_HOME=https://www.danielmoch.com; export WWW_HOME
		EDITOR=ed; export EDITOR
		FCEDIT=$EDITOR; export FCEDIT
		unset SSH_AGENT_PID
		SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`; export SSH_AUTH_SOCK
		PKG_PATH=https://cdn.openbsd.org/pub/OpenBSD/snapshots/packages/amd64; export PKG_PATH
		GPG_TTY=$(tty)
		gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
		HISTSIZE=1000; export HISTSIZE
		HISTFILE="$HOME/.sh_history"; export HISTFILE
		HISTCONTROL=erasedups; export HISTCONTROL
		VISUAL=vi; export VISUAL
		MOZ_ACCELERATED=1; export MOZ_ACCELERATED
		wsconsctl mouse.reverse_scrolling=1 >/dev/null
		;;
esac
