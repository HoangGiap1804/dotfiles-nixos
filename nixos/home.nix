{ config, pkgs, ... }:

{
  home.username = "nqim";
  home.homeDirectory = "/home/nqim";

  # Đặt version để tránh cảnh báo
  home.stateVersion = "25.05";

  programs.git.enable = true;
  programs.neovim.enable = true;

  home.packages = with pkgs; [
    wget
    curl
    htop
    neofetch  
    waybar
    rofi-wayland
    hyprpaper
    kitty
    stow
    ripgrep
    clang
    hyprpaper
    unzip
    tmux

    oh-my-posh
    fastfetch

    kdePackages.dolphin

    python3Full
    python3Packages.pywal
    python3Packages.pip
    libGL
    xorg.libX11
    xorg.libXext
    xorg.libXrender

    nerd-fonts.hack

    # lsp program server
    lua-language-server
    stylua
  ];
}

