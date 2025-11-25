#/home/$(echo $USER)/.nix-profile/bin/bash

DEFAULT_RES="1920x1080"
DEFAULT_RATE="60"

for monitor in $(xrandr --query | grep " connected" | cut -d ' ' -f1); do
    xrandr --output "$monitor" --mode "$DEFAULT_RES" --rate "$DEFAULT_RATE"
done
