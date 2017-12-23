#!/usr/bin/env bash
# modified from http://ficate.com/blog/2012/10/15/battery-life-in-the-land-of-tmux/

SMILE='☻ '

uname=$(uname -s)

case $uname in 
    *Linux*)
        if [[ $(acpi | wc -l) -eq 2 ]]
        then
            current_charge=$(acpi | awk 'getline' | awk '{print $4}' | sed 's~%~~' | sed 's~,~~')
        else
            current_charge=$(acpi | awk '{print $4}' | sed 's~%~~' | sed 's~,~~')
        fi
        total_charge=100
        ;;
    *Darwin*)
        battery_info=`ioreg -rc AppleSmartBattery`
        current_charge=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
        total_charge=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
        ;;
    *CYGWIN*)
        current_charge=$(wmic path Win32_Battery Get EstimatedChargeRemaining /format:list 2>/dev/null | grep '[^[:blank:]]' | cut -d= -f2)
        total_charge=100
        ;;
    *)
        echo "no battery status"
esac

charged_slots=$(echo "((($current_charge/$total_charge)*10)/3)+1" | bc -l | cut -d '.' -f 1)
if [[ $charged_slots -gt 3 ]]; then
  charged_slots=3
fi

echo -n '#[fg=colour108]'
for i in `seq 1 $charged_slots`; do echo -n "$SMILE"; done

if [[ $charged_slots -lt 3 ]]; then
  echo -n '#[fg=colour131]'
  for i in `seq 1 $(echo "3-$charged_slots" | bc)`; do echo -n "$SMILE"; done
fi
