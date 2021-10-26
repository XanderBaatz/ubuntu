#!/bin/bash
# wget -qO- https://git.io/JiliQ | sudo sh

#delete all packages except for generic kernel, grub, ubuntu-minimal...
e_pkgs="linux-generic*|grub*|ubuntu-minimal|ubuntu-standard"

sudo apt-mark auto $(apt list --installed | cut -f1 -d'/' | grep -v "^Listing" | grep -E -v "linux-generic*|grub*|ubuntu-minimal|ubuntu-standard") && sudo apt autoremove --purge -y && sudo apt autoclean all -y
sudo update-grub
