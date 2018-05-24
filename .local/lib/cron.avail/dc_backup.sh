#!/bin/sh
mount /mnt/timecapsule
rsync -aq danielmoch.com::backup /mnt/timecapsule/urbock.borg
umount /mnt/timecapsule
