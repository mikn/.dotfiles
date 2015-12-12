#! /bin/bash
set -e
SOURCES << EOF
deb http://httpredir.debian.org/debian/ wheezy main contrib non-free
deb-src http://httpredir.debian.org/debian/ wheezy main contrib non-free

deb http://httpredir.debian.org/debian/ testing main contrib non-free
deb-src http://httpredir.debian.org/debian/ testing main contrib non-free

deb http://security.debian.org/ testing/updates main contrib non-free
deb-src http://security.debian.org/ testing/updates main contrib non-free

deb http://httpredir.debian.org/debian/ unstable main contrib non-free
deb-src http://httpredir.debian.org/debian/ unstable main contrib non-free

deb http://httpredir.debian.org/debian/ experimental main contrib non-free
deb-src http://httpredir.debian.org/debian/ experimental main contrib non-free
EOF
UNSTABLE_PREF << EOF
Package: *
Pin: release a=unstable
Pin-Priority: 450
EOF
NVIDIA_PREF << EOF
Package: /nvidia/
Pin: release a=experimental
Pin-Priority: 550
EOF
echo $SOURCES > /etc/apt/sources.list
echo $UNSTABLE_PREF > /etc/apt/preferences.d/010-unstable
echo $NVIDIA_PREF > /etc/apt/preferences.d/015-nvidia
apt-get update
apt-get install bumblebee-nvidia i965-va-driver firmware-iwlwifi xserver-xorg-video-intel xserver-xorg-video-nvidia xbacklight mesa-utils
apt-get install tlp --no-install-recommends
sed -i /etc/default/grub 's/"quiet"/"quiet 915.preliminary_hw_support=1 pcie_aspm=force i915.enable_rc6=7"/'
