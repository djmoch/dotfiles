#!/bin/sh

exec 2>"$XDG_DATA_HOME/log/xinit-errors"
exec "$HOME/.xsession"
