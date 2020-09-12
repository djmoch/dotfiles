#!/bin/sh
mount /mnt/timecapsule
openrsync -a --del danielmoch.com::backup /mnt/timecapsule/webhost.borg
umount /mnt/timecapsule
