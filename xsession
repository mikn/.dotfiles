#! /bin/bash
HIDPI=false
xrdb -merge ~/.Xresources
xrdb -merge ~/devel/base16-xresources/xresources/base16-mexico-light-256.Xresources
DPI=96
if $HIDPI; then
	DPI=192
	export QT_SCALE_FACTOR=2
	xrdb -merge <(echo '*.dpi: 192')
	xrdb -merge <(echo 'rofi.dpi: 192')
else
	#xrandr --output eDP-1 --mode 1920x1080 --primary
	#xrandr --output HDMI-1 --mode 1920x1080 -left-of eDP-1

	xrandr --output DP-1-8 --mode 3440x1440 --primary --output eDP-1 --off # --mode 1920x1080 --left-of DP-1-8
	#xrandr --output HDMI-1 --auto --primary --output eDP-1 --off # --mode 1920x1080 --left-of DP-1-8
	#xset s off
	#xset -dpms
	xrdb -merge <(echo '*.dpi: 96')
	xrdb -merge <(echo 'rofi.dpi: 96')
fi
	

xrandr --dpi $DPI
nitrogen --restore
compton -bCG --backend glx --vsync opengl-swc --paint-on-overlay --unredir-if-possible  --glx-no-stencil --glx-no-rebind-pixmap
/usr/bin/i3
