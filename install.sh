#!/bin/bash

# Add Home Manager 25.05 channel
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
sudo nix-channel --update

# i3
mkdir -p ~/.config/i3/
cp ./config ~/.config/i3/

# Polybar
mkdir -p ~/.config/polybar/
cp ./config.ini ~/.config/polybar/
cp ./launch.sh ~/.config/polybar/
chmod +x ~/.config/polybar/launch.sh

# Wallpaper
mkdir -p ~/Photos/
cp ./wall.png ~/Photos/

# Kitty
mkdir -p ~/.config/kitty/
cp ./kitty.conf ~/.config/kitty/
cp ./current-theme.conf ~/.config/kitty/

# NixOS
sudo cp ./configuration.nix /etc/nixos/configuration.nix

