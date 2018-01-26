#!/usr/bin/env bash
# modified from http://ficate.com/blog/2012/10/15/battery-life-in-the-land-of-tmux/

SMILE='☻ '

charged_slots=$(echo "`my battery percent`/30+1" | bc -l | cut -d '.' -f 1)
if [[ $charged_slots -gt 3 ]]; then
  charged_slots=3
fi

echo -n '#[fg=colour108]'
for i in `seq 1 $charged_slots`; do echo -n "$SMILE"; done

if [[ $charged_slots -lt 3 ]]; then
  echo -n '#[fg=colour131]'
  for i in `seq 1 $(echo "3-$charged_slots" | bc)`; do echo -n "$SMILE"; done
fi
