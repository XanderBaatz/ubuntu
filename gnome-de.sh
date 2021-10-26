#!/bin/bash
# wget -qO- 

sudo apt update -y

#xorg and libinput
sudo apt install --no-install-recommends --no-install-suggests \
xinit \
xserver-xorg-input-libinput

#gnome de
sudo apt install --no-install-recommends --no-install-suggests \
gnome-session \
gnome-control-center \
gnome-terminal \
gnome-tweak-tool \
xdg-user-dirs \
gdm3 \
gnome-keyring \
nautilus

sudo startx
