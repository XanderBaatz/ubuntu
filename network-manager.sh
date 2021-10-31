#!/bin/bash
# wget -qO- https://git.io/Jily6 | sudo sh

#install network-manager
sudo apt install -y --no-install-recommends --no-install-suggests \ 
network-manager

sudo systemctl disable systemd-networkd.service
sudo systemctl disable systemd-networkd.socket

sudo systemctl mask systemd-networkd.service
sudo systemctl mask systemd-networkd.socket

sudo systemctl stop systemd-networkd.service
sudo systemctl stop systemd-networkd.socket

sudo cp /etc/netplan/*.yaml $(ls /etc/netplan/*.yaml).bak
sudo rm -rf /etc/netplan/*.yaml

sudo sh -c 'cat << EOF > /etc/netplan/01-network-manager-all.yaml
network:
  version: 2
  renderer: NetworkManager
EOF'

#enable netplan to use networkmanager instead of networkd
sudo netplan generate
sudo netplan apply

#enable and restart networkmanager service
sudo systemctl enable NetworkManager.service
sudo systemctl restart NetworkManager.service
