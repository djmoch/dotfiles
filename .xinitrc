#
# ~/.xinitrc
#
exec 2>"$HOME/.xinit-errors"
[ -r "$HOME/.Xresources" ] && xrdb "$HOME/.Xresources"
exec "$HOME/.xsession"
