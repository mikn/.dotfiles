#! /bin/bash
xrandr --dpi 96
xrandr --output HDMI1 --primary --mode 3440x1440 --output eDP1 --off
xrdb -merge ~/.Xresources
nitrogen --restore
/usr/bin/i3
