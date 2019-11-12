#! /bin/bash

swaylock -i ~/Pictures/04194_pagview_1920x1080.jpg $1 &

swaylock_pid="$!"

/usr/bin/swayidle -w timeout 10 'swaymsg "output * dpms off"' \
                resume 'swaymsg "output * dpms on"' &

swayidle_pid="$!"

wait ${swaylock_pid}
kill ${swayidle_pid}
