#!/bin/bash
# wget -qO- https://git.io/Jily6 | sudo sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

sudo apt install -y network-manager --no-install-recommends

sudo systemctl disable systemd-networkd.{service,socket}
sudo systemctl mask systemd-networkd.{service,socket}
sudo systemctl stop systemd-networkd.{service,socket}

sudo cp /etc/netplan/*.yaml $(ls /etc/netplan/*.yaml).bak
sudo rm -rf /etc/netplan/*.yaml

sudo sh -c 'cat << EOF > /etc/netplan/01-network-manager-all.yaml
network:
  version: 2
  renderer: NetworkManager
EOF'

# setup netplan for NM
sudo netplan generate
sudo netplan apply
# make sure NM is running
sudo systemctl enable NetworkManager.service
sudo systemctl restart NetworkManager.service
