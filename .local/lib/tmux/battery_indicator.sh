#!/bin/sh
#
# ~/.local/lib/tmux/battery_indicator.sh
#
SMILE='☻ '

battery_percent=`my battery percent`
charged_slots=$(($battery_percent/30+1))
[ $charged_slots -gt 3 ] && charged_slots=3

echo -n '#[fg=colour108]'
for i in `seq 1 $charged_slots`; do echo -n "$SMILE"; done

if [ $charged_slots -lt 3 ]; then
  echo -n '#[fg=colour131]'
  uncharged_slots=$((3-$charged_slots))
  for i in `seq 1 $uncharged_slots`; do echo -n "$SMILE"; done
fi
