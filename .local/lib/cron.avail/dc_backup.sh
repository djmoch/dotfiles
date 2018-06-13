#!/bin/sh
mount /mnt/timecapsule
rsync -aq --del danielmoch.com::backup /mnt/timecapsule/webhost.borg
umount /mnt/timecapsule
