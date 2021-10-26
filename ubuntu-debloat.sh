#!/bin/bash

#delete all packages except for generic kernel, grub, ubuntu-minimal
e_pkgs="linux-generic*|grub*|ubuntu-minimal"

sudo sh -c "apt-mark auto $(apt list --installed | cut -f1 -d'/' | grep -v "^Listing" | grep -E -v "${e_pkgs}") -y && apt autoremove --purge -y && apt autoclean all -y"
