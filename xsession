#! /bin/bash
ulimit -n 4096
xrdb -merge ~/.Xresources
xrdb -merge ~/devel/base16-xresources/xresources/base16-mexico-light-256.Xresources

xset s 300

setxkbmap -model pc105 -layout us,se -option grp:alt_shift_toggle
udiskie -Ans &
xss-lock -- $HOME/bin/lock.sh &

compton -bC --backend glx --paint-on-overlay --unredir-if-possible  --glx-no-stencil --glx-no-rebind-pixmap
~/bin/screenlayout
/usr/bin/dropbox &
/usr/bin/i3
