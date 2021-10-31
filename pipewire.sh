#!/bin/bash
# wget -qO- https://git.io/JilFv | sudo sh

# Full credit to 1nfern0 and pipewire-debian
# https://askubuntu.com/a/1339897
# https://github.com/pipewire-debian/pipewire-debian

#install ppa requirements
sudo apt-get install software-properties-common -y

###################################################################

#add pipewire ppa to obtain the latest pipewire upstream
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream -y

#update repositories
sudo apt update -y

#install pipewire package
sudo apt install pipewire -y

#install bluetooth dependency
sudo apt install libspa-0.2-bluetooth -y

#install pipewire client libraries
sudo apt install pipewire-audio-client-libraries -y

#reload the daemon
sudo systemctl --user daemon-reload

#enable pipewire media session
sudo systemctl --user --now enable pipewire-media-session.service

#list pipewire processes
echo "Pipewire processes:"
ps -e | grep pipewire
