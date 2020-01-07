type dunst >/dev/null 2>&1 || return
[ "$1" = "dwm" ] || return
dunst &
