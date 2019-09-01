#!/bin/sh
#
# ~/.local/lib/tmux/battery_indicator.sh
#
SMILE='☻ '

charged_slots=$((`my battery percent` / 25))
[ $charged_slots -gt 3 ] && charged_slots=3

echo -n '#[fg=green]'
for i in `seq 1 $charged_slots`; do echo -n "$SMILE"; done

if [ $charged_slots -lt 3 ]; then
  echo -n '#[fg=red]'
  uncharged_slots=$((3-$charged_slots))
  for i in `seq 1 $uncharged_slots`; do echo -n "$SMILE"; done
fi
