#!/bin/bash

# Add Home Manager 25.05 channel
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
sudo nix-channel --update

mkdir -p ~/.config/i3/
cp ./config ~/.config/i3/

sudo cp ./configuration.nix /etc/nixos/configuration.nix

