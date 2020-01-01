#
# ~/.profile
#
__addpath ()
{
	if [ -d "$1" ]
	then
	case ":$PATH:" in
		*:"$1":*)
			;;
		*)
			if [ -z "$2" ]
			then
				PATH="$PATH:$1"
			else
				PATH="$1:$PATH"
			fi
	esac
	fi
}

for file in "$HOME"/etc/profile.d/*.sh
do
	[ -r $file ] && . $file
done

unset __addpath
export PATH

if type my-init > /dev/null 2>&1 && [ ! -f "$HOME/._.djmoch" ]
then
	my-init
fi

my login
