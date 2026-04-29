{ config, pkgs, ... }:

{
  home.username = "nqim";
  home.homeDirectory = "/home/nqim";
  home.stateVersion = "25.11"; # chỉnh theo version NixOS của bạn

  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/quickshell".source = ./config/quickshell;
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
    tmux
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
  ];

}
