{ config, pkgs, ... }:

{
  home.username = "nqim";
  home.homeDirectory = "/home/nqim";
  home.stateVersion = "24.05"; # chỉnh theo version NixOS của bạn

  # 🛠 Packages cài cho user
  home.packages = with pkgs; [
    wget
    curl
    htop
    neofetch  
    rofi
    kitty
    stow
    ripgrep
    clang
    unzip
    tmux
    fzf
    bat

    pywal

    oh-my-posh
    fastfetch

    quickshell

    nerd-fonts.hack

    swww
    
    jetbrains.idea-ultimate
    lazydocker
    vscode
    postman
    jdk17

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
  ];

}
