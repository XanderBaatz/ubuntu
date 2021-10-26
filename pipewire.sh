#!/bin/bash
# wget -qO- https://git.io/JilFv | sudo sh

# Full credit to reddit user MaundeRZ
# https://www.reddit.com/r/Ubuntu/comments/o7xd3n/dirty_script_to_make_pipewire_the_default_and/
# I only "ported" the script to experiment with it, and for educational purposes.

#install ppa requirements
sudo apt-get install software-properties-common -y

###################################################################

# OUTPUT-COLORING
red='\e[0;31m'
green='\e[0;32m'

# echo success of failure depending on command result
# result $? has to be assigned to a varialbe 
# and be passed as argument
function execute_command {
  eval $1
  if [ $? = 0 ]
  then
    echo -e "${green}OK${NC}: "$1" successfully executed"
  else
    echo -e "${red}Fail${NC}: "$1""
  fi
}

echo -e "Lazy install script according to https://github.com/pipewire-debian/pipewire-debian/wiki"

# Add the PPA
add_ppa_pipewire_upstream="sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream"
execute_command "$add_ppa_pipewire_upstream"

# Update Repository Cache
update_repository_cache="sudo apt update"
execute_command "$update_repository_cache"

# Install dependencies
install_dependencies="sudo apt install libfdk-aac2 libldacbt-{abr,enc}2 libopenaptx0 -y"
execute_command "$install_dependencies"

# Install pipewire and additonal packages
install_pipewire_and_add_ons="sudo apt install gstreamer1.0-pipewire libpipewire-0.3-{0,dev,modules} libspa-0.2-{bluetooth,dev,jack,modules} pipewire{,-{audio-client-libraries,pulse,media-session,bin,locales,tests}} -y"
execute_command "$install_pipewire_and_add_ons"

# Remove official blueman before installing blueman-git
remove_blueman="sudo apt-get remove --purge blueman && sudo rm -f /var/lib/blueman/network.state"
execute_command "$remove_blueman"

# Install blueman-git
install_blueman_git="sudo apt install blueman-git"
execute_command "$install_blueman_git"

# You don't need to uninstall PulseAudio to enable PipeWire, disable and mask PulseAudio related services to stop them
disable_pulseaudio="systemctl --user --now disable  pulseaudio.{socket,service}"
execute_command "$disable_pulseaudio"

# Mask pulseaudio
mask_pulseaudio="systemctl --user mask pulseaudio"
execute_command "$mask_pulseaudio"

# Stop pulseaudio respawn
stop_pulseaudo_respawn="sed -i 's/.*autospawn.*/autospawn = no/g' ~/.config/pulse/client.conf"
execute_command "$stop_pulseaudo_respawn"

# disable autosapwn in pulse ~/.config/pulse/client.conf
disable_pulse_auto_spawn_user="sed -i 's/.*autospawn.*/autospawn = no/g' ~/.config/pulse/client.conf"
execute_command "$disable_pulse_auto_spawn_user"

# if config in home direcotry is not available edit global pulse config
disable_pulse_auto_spawn_global="sudo sed -i 's/.*autospawn.*/autospawn = no/g' /etc/pulse/client.conf"
execute_command "$disable_pulse_auto_spawn_global"

# kill pulseeffect
kill_pulseaudio="pulseaudio --kill"
execute_command "$kill_pulseaudio"

# Since version 0.3.23 config files are moved the overwrite behaviour is:
# $HOME/.config/pipewire > /etc/pipewire > /usr/share/pipewire

# copy files from /usr/share/pipewire to /etc/
copy_config_etc="sudo cp -vRa /usr/share/pipewire /etc/"
execute_command "$copy_config_etc"

# Enable and start pipewire related services
enable_pipewire="systemctl --user --now enable pipewire{,-pulse}.{socket,service} pipewire-media-session.service"
execute_command "$enable_pipewire"

# enable blueman-git
enable_blueman_git="sudo systemctl enable --now blueman-mechanism.service"
execute_command "$enable_blueman_git"

# check audio server
check_audio_server="pactl info | grep '^Server Name'"
execute_command "$check_audio_server"

# Reboot Message
echo -e "Do not forget to reboot - also solves the no sound issue"
