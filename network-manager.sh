#!/bin/bash
# wget -qO- https://git.io/Jily6 | sudo sh

set -e

#check package: network-manager
i_pkg="network-manager"

#install network-manager
sudo apt install --no-install-recommends --no-install-suggests -y ${i_pkg}

#exit if network-manager isn't installed
if [ $(dpkg-query -W -f='${Status}' ${i_pkg} | grep -q -P '^install ok installed$'; echo $?) != "0" ]; then
  echo "Unable to install ${i_pkg} , aborting."
  exit $1
fi

#disable networkd
for s in $(systemctl | grep "systemd-networkd." | awk '{print $1}'); do
  sudo systemctl disable $s;
  sudo systemctl mask $s;
  sudo systemctl stop $s
done

#remove obsolete package "networkd-dispatcher"
sudo apt autoremove --purge networkd-dispatcher -y

#backup old netplan configuration
sudo cp /etc/netplan/*.yaml $(ls /etc/netplan/*.yaml).bak
sudo rm -rf /etc/netplan/*.yaml

#create networkmanager config for netplan
sudo sh -c 'cat << EOF > /etc/netplan/01-network-manager-all.yaml
network:
  version: 2
  renderer: NetworkManager
EOF'

#enable netplan to use networkmanager instead of networkd
sudo netplan generate
sudo netplan apply

#reload system daemon (services etc.)
sudo systemctl daemon-reload

#enable and restart networkmanager service
sudo systemctl enable NetworkManager.service
sudo systemctl restart NetworkManager.service
