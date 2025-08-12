# Installation
```
$ git clone git@github.com:jaysonnutt/nixos.git
$ cd nixos
$ sudo cp /etc/nixos/hardware-configuration.nix .
$ sudo chown -R <user>:<group> hardware-configuration.nix
$ cp ./home.nix ~/.config/home-manager/home.nix
$ sudo nixos-rebuild switch --flake .
$ home-manager switch
```

