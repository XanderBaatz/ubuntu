#!/bin/sh
# wget -qO- https://git.io/JimfW | sudo sh

set -e

# variables
dist_name=$(uname -n)
code_name=$(cat /etc/*-release | grep DISTRIB_CODENAME| cut -f2 -d'=')
deb_code_name=$(dpkg --status tzdata | grep Provides| cut -f2 -d'-')
repo_url=$(cat /etc/apt/sources.list | grep -o "deb http[^']\+${dist_name}" | head -1 | cut -f2 -d' ')
component="main restricted universe multiverse"

# backup
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# sources.list generation
sudo sh -c "cat << EOF > /etc/apt/sources.list
deb ${repo_url} ${code_name} ${component}
deb-src ${repo_url} ${code_name} ${component}

deb ${repo_url} ${code_name}-updates ${component}
deb-src ${repo_url} ${code_name}-updates ${component}

deb ${repo_url} ${code_name}-security ${component}
deb-src ${repo_url} ${code_name}-security ${component}

deb ${repo_url} ${code_name}-backports ${component}
deb-src ${repo_url} ${code_name}-backports ${component}

deb http://archive.canonical.com/ubuntu ${code_name} partner
deb-src http://archive.canonical.com/ubuntu ${code_name} partner
EOF"

# update sources
sudo apt update
