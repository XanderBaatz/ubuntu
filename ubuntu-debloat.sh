#!/bin/bash
# wget -qO- https://git.io/JiliQ | sudo sh

#delete all packages except for generic kernel, grub, ubuntu-minimal...
e_pkgs="linux-generic*|grub*|ubuntu-minimal"

#capture timezone
time_zone=$(timedatectl | grep "Time zone" | awk '{print $3}')

sudo apt-mark auto $(apt list --installed | cut -f1 -d'/' | grep -v "^Listing" | grep -E -v "${e_pkgs}") && sudo apt autoremove --purge -y && sudo apt autoclean all -y
sudo apt update -y && sudo apt upgrade -y
sudo apt install ubuntu-standard -y
sudo timedatectl set-timezone ${time_zone}
sudo update-grub
