{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jayson";
  home.homeDirectory = "/home/jayson";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    pkgs.morewaita-icon-theme

    # Burpsuite and all of its dependencies
    #pkgs.burpsuite
    #pkgs.openjdk
    #pkgs.gtk3
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jayson/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  ## Custom

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
      edithome="nvim ~/.config/home-manager/home.nix";
      editconfig="nvim ~/nixos/configuration.nix";
      update="sudo nixos-rebuild switch --flake ~/nixos/ && home-manager switch";
      updatehome="home-manager switch";
      updateconfig="sudo nixos-rebuild switch --flake ~/nixos/";
    };
  };

  programs.git = {
    enable = true;
    userName = "Jayson Nutt";
    userEmail = "jayson.nutt@gmail.com";
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      
      # Reload config file
      bind r source-file ~/.tmux.conf
      
      # Switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
      
      # Enable mouse control (clickable windows, panes, resizable panes)
      set -g mouse on
      
      # Don't rename windows automatically
      set-option -g allow-rename off
      
      # Set escape-time
      set-option -sg escape-time 10
    '';
  };

  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = "Adwaita";
      gtk-theme = "Adwaita-dark";
      color-scheme = "prefer-dark";
      icon-theme = "MoreWaita";
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/jayson/nixos/assets/wallpaper.jpg";
      picture-uri-dark = "file:///home/jayson/nixos/assets/wallpaper.jpg";
      picture-options = "zoom";
    };
  };
}

