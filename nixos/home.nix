{ config, pkgs, ... }:

{
  home.username = "nqim";
  home.homeDirectory = "/home/nqim";

  # Đặt version để tránh cảnh báo
  home.stateVersion = "23.05";

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

    oh-my-posh
    fastfetch

    kdePackages.dolphin
    kdePackages.qt6ct

    python3
    python3Packages.pywal

    nerd-fonts.hack

    # lsp program server
    lua-language-server
    stylua
  ];
}

