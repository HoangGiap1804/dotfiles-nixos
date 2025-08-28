{ config, pkgs, ... }:

{
  home.username = "nqim";
  home.homeDirectory = "/home/nqim";

  # Đặt version để tránh cảnh báo
  home.stateVersion = "23.05";

  programs.zsh.enable = true;
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
  ];

  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
}

