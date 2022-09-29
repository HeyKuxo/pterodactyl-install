#!/bin/bash

echo "Updating System & adding deps"
apt update

apt upgrade -y 

apt install curl wget

echo "Installing Docker"
curl -sSL https://get.docker.com/ | CHANNEL=stable bash

echo "Enableing Docker on boot"
systemctl enable --now docker

echo "Making Pterodactyl Dir"

mkdir -p /etc/pterodactyl

echo "Installing Wings"

curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"

chmod u+x /usr/local/bin/wings

echo "Adding wings Service"

curl -L -o /etc/systemd/system/ "https://raw.githubusercontent.com/HeyKuxo/pterodactyl-install/main/wings.service"

echo "Enabling wings on boot"

systemctl enable wings

echo "Install Complete"
echo "Make sure to enrole the node onto the panel before rebooting!"