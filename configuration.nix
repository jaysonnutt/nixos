# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, callPackage, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # HOME MANAGER
  home-manager.users.jayson = { pkgs, ... }: {
    home.packages = [  ];
    
    # Neovim (nvim)
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraConfig = ''
        """ Main Configuration
        set number
        set relativenumber
        set title
        set hidden
        set encoding=utf-8
        set incsearch ignorecase smartcase hlsearch
        set backspace=indent,eol,start
        set path+=**
        set wildmenu
        set mouse=a
        set autoindent
        set linebreak
        set noerrorbells
        set history=1000
        
        syntax enable
        let mapleader=","
        
        """ Mappings
        inoremap jj <ESC>
        nnoremap B ^
        nnoremap E $
        nnoremap $ <NOP>
        nnoremap ^ <NOP>
        nnoremap ; :Files<CR>
        
        "" Mappings for window movement when using split screen
        inoremap <c-h> <c-w>h
        inoremap <c-l> <c-w>l
        inoremap <c-j> <c-w>j
        inoremap <c-k> <c-w>k
        
        "" Duplicates for normal mode
        nnoremap <c-h> <c-w>h
        nnoremap <c-l> <c-w>l
        nnoremap <c-j> <c-w>j
        nnoremap <c-k> <c-w>k
        
        colorscheme slate
      '';
    };

    programs.bash = {
      enable = true;
      initExtra = ''
      '';
      shellAliases = {
        ll="ls -al";
	e="nvim";
	vi="nvim";
	vim="nvim";
	ec="nvim /etc/nixos/configuration.nix";
	ei="nvim ~/.config/i3/config";
	update="sudo nixos-rebuild switch";
	ff="fastfetch";
      };
    };

    programs.git = {
      enable = true;
      userName = "Jayson Nutt";
      userEmail = "jayson.nutt@gmail.com";
    };

    # This value determines the Home Manager release that your configuration is 
    # compatible with. This helps avoid breakage when a new Home Manager release 
    # introduces backwards incompatible changes. 
    #
    # You should not change this value, even if you update Home Manager. If you do 
    # want to update the value, then make sure to first check the Home Manager 
    # release notes. 
    home.stateVersion = "24.05"; # Please read the comment before changing. 
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Pacific/Honolulu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
	i3status
	i3blocks
      ];
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  services.displayManager.defaultSession = "none+i3";

  programs.i3lock.enable = true;

  programs.dconf.enable = true;

  # Enable LightDM
  services.displayManager.sddm.enable = false;
  services.xserver.displayManager.lightdm.enable = true;

  services.xserver.displayManager.lightdm.greeters.gtk.enable = true;

  # Set the greeter's GTK theme to a dark variant (e.g., Adwaita-dark or another dark theme)
  services.xserver.displayManager.lightdm.greeters.gtk.theme.name = "Adwaita-dark";

  # --- Set the background to a hex color ---
  services.xserver.displayManager.lightdm.background = "#202020";

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jayson = {
    isNormalUser = true;
    description = "Jayson";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    lxappearance
    brave
    fastfetch
    alacritty
    kitty
    alacritty-theme
    rofi

    # Cybersecurity
    nmap
    aircrack-ng
    ghidra
    john
    metasploit
    wireshark
    cutter
    gdb
    flare-floss
    yara

    # General
    flameshot
    adapta-gtk-theme
    adwaita-icon-theme
    vlc
    btop
    tree
    curl
    wget
    gnome-tweaks
    yazi
    fzf
    binutils
    adwaita-icon-theme
    polybar
    killall
    feh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  
  virtualisation.vmware.guest.enable = true;

  environment.pathsToLink = [ "/libexec" ];

  services.openssh.enable = true;
}
