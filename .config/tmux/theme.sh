#### COLOUR

tm_color_active=colour67
tm_color_inactive=colour242
tm_color_feature=colour131
tm_active_border_color=colour67

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5


# default statusbar colors
# set-option -g status-bg colour0
set-option -g status-fg $tm_color_active
set-option -g status-bg default
set-option -g status-attr default

# default window title colors
set-window-option -g window-status-fg $tm_color_inactive
set-window-option -g window-status-bg default
set -g window-status-format "#I #W"

# active window title colors
set-window-option -g window-status-current-fg $tm_color_active
set-window-option -g window-status-current-bg default
set-window-option -g  window-status-current-format "#[bold]#I #W"

# pane border
set-option -g pane-border-fg $tm_color_inactive
set-option -g pane-active-border-fg $tm_active_border_color

# message text
set-option -g message-bg default
set-option -g message-fg $tm_color_active

# pane number display
set-option -g display-panes-active-colour $tm_color_active
set-option -g display-panes-colour $tm_color_inactive

# clock
set-window-option -g clock-mode-colour $tm_color_active

tm_weather="#[fg=$tm_color_feature]#(cat ~/.config/forecastio/current_forecast.txt)"
tm_battery="#(~/.config/tmux/bin/battery_indicator.sh)"

tm_date="#[fg=$tm_color_inactive] %R %d %b"
tm_host="#[fg=$tm_color_feature,bold]#h"
tm_session_name="#[fg=$tm_color_feature,bold]\[#S\]"

set -g status-left $tm_session_name' '
set -g status-right $tm_battery' '$tm_weather' '$tm_date' '$tm_host

set-environment -gu tm_color_active
set-environment -gu tm_color_inactive
set-environment -gu tm_color_feature
set-environment -gu tm_weather
set-environment -gu tm_battery
set-environment -gu tm_date
set-environment -gu tm_host
set-environment -gu tm_session_name
set-environment -gu tm_active_border_color
# vim: ft=tmux
