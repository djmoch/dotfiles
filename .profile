PATH="$PATH:$HOME/bin"; export PATH
HOSTNAME=$(hostname | cut -d. -f1); export HOSTNAME
ENV="$HOME/etc/shrc"; export ENV
LANG=en_US.UTF-8; export LANG
EDITOR=ed; export EDITOR
FCEDIT=ed; export FCEDIT
XDG_CONFIG_HOME="$HOME/etc"; export XDG_CONFIG_HOME
XDG_CACHE_HOME="$HOME/var/cache"; export XDG_CACHE_HOME
XDG_DATA_HOME="$HOME/var"; export XDG_DATA_HOME
PYTHONUSERBASE="$HOME"; export PYTHONUSERBASE
GOPATH="$HOME"; export GOPATH
TMPDIR="$HOME/tmp"; export TMPDIR

case $HOSTNAME in
	carbon)
		font=/lib/font/bit/lucsans/boldunicode.7.font; export font
		PLAN9=/usr/local/plan9; export PLAN9
		PATH="$PATH:$PLAN9/bin"; export PATH
		BROWSER=firefox-esr; export BROWSER
		EDITOR=E; export EDITOR
		PAGER=nobs; export PAGER
		FCEDIT=$EDITOR; export FCEDIT
		unset SSH_AGENT_PID
		SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`; export SSH_AUTH_SOCK
		PKG_PATH=https://cdn.openbsd.org/pub/OpenBSD/snapshots/packages/amd64; export PKG_PATH
		GPG_TTY=$(tty)
		gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
		MOZ_ACCELERATED=1; export MOZ_ACCELERATED
		PASSWORD_STORE_DIR=$XDG_CACHE_HOME/password-store; export PASSWORD_STORE_DIR
		XAUTHORITY="$XDG_CACHE_HOME/Xauthority"; export XAUTHORITY
		wsconsctl mouse.reverse_scrolling=1 >/dev/null
		if [ "$(tty)" = "/dev/ttyC0" ]
		then
			exec startx
		fi
		;;
	mail)
		MAIL=$HOME/Maildir; export MAIL
		PAGER=cat; export PAGER
		;;
esac
