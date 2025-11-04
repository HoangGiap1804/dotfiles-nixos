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
    waybar
    rofi
    hyprpaper
    kitty
    stow
    ripgrep
    clang
    hyprpaper
    unzip
    tmux
    fzf
    bat

    pywal

    oh-my-posh
    fastfetch

    kdePackages.dolphin

    quickshell

    nerd-fonts.hack

    # lsp program server
    lua-language-server
    stylua
    mysql-workbench

    postman
    swww
    
    jetbrains.idea-ultimate
    lazydocker
    vscode
    code-cursor-fhs
    postman
    pgadmin4-desktopmode
    jdk17

    drawio

    burpsuite
  ];

}
