#!/bin/bash
# wget -qO- https://git.io/JiliQ | sudo sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#delete all packages except for generic kernel, grub, ubuntu-minimal...
e_pkgs="linux-generic*|grub*|ubuntu-minimal"

sudo apt-mark auto $(apt list --installed | cut -f1 -d'/' | grep -v "^Listing" | grep -E -v "linux-generic*|grub*|ubuntu-minimal") && sudo apt autoremove --purge -y && sudo apt autoclean all -y
sudo apt update -y && sudo apt upgrade -y
sudo apt install ubuntu-standard -y
sudo update-grub
