type dwmstatus > /dev/null 2>&1 || return
[ "$1" = "dwm" ] || return
dwmstatus &
