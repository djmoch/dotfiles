#!/usr/bin/env bash
echo "Beginning sync on $(date)"
vdirsyncer sync
echo "Completed sync on $(date)"
