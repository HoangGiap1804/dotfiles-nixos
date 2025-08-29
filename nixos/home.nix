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

    kdePackages.dolphin

    nerd-fonts.hack

    # lsp program server
    lua-language-server
    stylua
  ];
}

