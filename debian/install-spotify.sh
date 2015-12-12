#! /bin/bash
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com testing non-free | tee /etc/apt/sources.list.d/spotify.list
apt-get update
apt-get install libpango-1.0-0 lbpangoxft-1.0-0 libcrypt11
apt-get install spotify-client
echo 'For HiDPI-scaling, run spotify with command "spotify --force-device-scale-factor=2"'
