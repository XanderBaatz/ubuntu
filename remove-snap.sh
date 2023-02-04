#!/bin/bash

# Unmount snap (to avoid read-only issue)
 sudo umount $(mount | grep snap | awk '{print $3}')
 
 # Fully remove snap and additional packages
 sudo apt purge snapd gnome-software-plugin-snap
 
 # Hold snap and additional packages so they do not get reinstalled
 sudo apt-mark hold snapd gnome-software-plugin-snap
