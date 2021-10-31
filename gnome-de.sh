#!/bin/bash
# wget -qO- https://git.io/Jil9P | sudo sh

sudo apt update -y && sudo apt upgrade -y

#install the packages required for "add-apt-repository"
sudo apt install  -y \
software-properties-common

#add popos repositories
sudo add-apt-repository ppa:system76/pop -y && sudo apt-get update -y && sudo apt upgrade -y

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

#pop shell tiling and other extensions
sudo apt install --no-install-recommends --no-install-suggests -y \
pop-shell \
gnome-shell-extension-appindicator

#enable installed gnome extensions
for e in $(gnome-extensions list); do
  gnome-extensions enable $e
done

echo ""
echo "Please reboot to finish the installation."
echo ""
