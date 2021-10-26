#!/bin/bash
# wget -qO- https://git.io/Jil9P | sudo sh

sudo apt update -y && sudo apt upgrade -y

#xorg and libinput
sudo apt install --no-install-recommends --no-install-suggests -y \
xinit \
xserver-xorg-input-libinput

#gnome de
sudo apt install --no-install-recommends --no-install-suggests -y \
gnome-session \
gnome-control-center \
gnome-terminal \
gnome-tweak-tool \
xdg-user-dirs \
gdm3 \
gnome-keyring \
nautilus \
breeze-cursor-theme

echo ""
echo "run 'startx' to launch gnome"
echo ""
