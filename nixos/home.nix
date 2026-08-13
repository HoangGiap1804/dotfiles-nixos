{ config, pkgs, inputs, ... }:

{
  home.username = "nqim"; home.homeDirectory = "/home/nqim";
  home.stateVersion = "25.11"; # chỉnh theo version NixOS của bạn

  home.file.".tmux.conf".source = ./config/tmux/.tmux.conf;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/quickshell".source = ./config/topbar-quickshell;
  home.file.".config/fastfetch".source = ./config/fastfetch;
  home.file.".poshthemes".source = ./config/oh-my-posh;

  home.file.".config/kitty" = {
    source = ./config/kitty;
    recursive = true;
  };
  home.file.".config/fish" = {
    source = ./config/fish;
    recursive = true;
    force = true;
  };
  home.file.".config/hypr" = {
    source = ./config/hypr;
    recursive = true;
    force = true;
  };

  programs.git = {
    enable = true;
    userName = "Nguyen Van Hoang Giap";
    userEmail = "hgiap1804@gmail.com";
  };

  programs.ssh = {
    enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark"; # "default" for light mode
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3"; 
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  # 🛠 Packages cài cho user
  home.packages = with pkgs; [
    wget
    curl
    htop
    neofetch  
    rofi
    kitty
    ripgrep
    unzip
    fzf
    pywal
    fastfetch
    quickshell
    nerd-fonts.hack
    swww
    jetbrains.idea-ultimate
    lazydocker
    vscode
    postman
    drawio
    libreoffice
    nautilus
    obs-studio
    openssl
    stripe-cli
    opencode
    mission-center
    brightnessctl
    # Flutter development
    flutter
    android-studio
    cmake
    ninja
    pkg-config
    gtk3
    cargo

    gnome-tweaks
    arc-theme

    blender

    nodejs_22
    pnpm 

    scrcpy

    vlc

    jdk17
    maven
    dbeaver-bin

    libnotify
    inotify-tools
    cloudflared
    envsubst
  ];

}
