#! /bin/bash
#python -c 'import secretstorage; secretstorage.get_default_collection(secretstorage.dbus_init()).lock()'
killall gnome-keyring-daemon
killall kpcli 2 > /dev/null
i3lock -i ~/Pictures/wallpapers/lockscreen.png
