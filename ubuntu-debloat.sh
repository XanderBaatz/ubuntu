#!/bin/bash

#delete all packages except for generic kernel, grub, ubuntu-minimal
sudo apt-mark auto $(apt list --installed | cut -f1 -d'/' | grep -v "^Listing" | grep -E -v "linux-generic*|grub*|ubuntu-minimal") -y && \
sudo apt autoremove --purge -y && apt autoclean all -y
