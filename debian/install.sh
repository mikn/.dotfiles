#! /bin/bash
# Installing essentials
apt-get install i3-wm i3lock suckless-tools wicd-curses xdm htop kpcli ranger w3m vim-nox feh aptitude xinit apt-file gnupg
# Installing dependencies for i3pystatus
apt-get install python3-pip python3-netifaces libiw-dev pulseaudio libpulse0
pip3 install basiciw libpulseaudio
# Installing vimrc dependencies
apt-get install silversearcher-ag
# screen script dependencies
apt-get install edid-decode
