{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/network.nix
      ./modules/users.nix
      ./modules/nvidia.nix
      ./modules/fish.nix
      ./modules/window_manager.nix
      ./modules/sddm.nix
      ./modules/properties.nix
      ./modules/tmux.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.upower.enable = true;

  services.udisks2.enable = true;     # Quản lý ổ đĩa
  services.gvfs.enable = true;        # Cung cấp mount tự động cho file manager
  services.devmon.enable = true;      # Tự động mount thiết bị

  services.blueman.enable = true;   # Enables the Blueman manager
  hardware.bluetooth.enable = true; # Enables Bluetooth support
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    vim 
    git
    wget
    grim
    slurp
    wl-clipboard
    firefox
    neovim
    blueman
    bluez
    home-manager
    docker-compose
    oh-my-posh
    clang
    cmake
    meson
    cpio
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Dolphin + KDE dependencies (Nothing OS theme)
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-extras            # thumbnails, network locations
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ffmpegthumbs          # video thumbnails
    kdePackages.breeze-icons          # fallback icon theme
    kdePackages.kservice              # kbuildsycoca6
    kdePackages.xdg-desktop-portal-kde # file picker portal for Dolphin
    darkly                            # Qt widget style (Darkly)
  ];

  programs.adb.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    zstd
    curl
    openssl
    attr
    libssh
    libxml2
    acl
    libtool
    sqlite
    glib
    ncurses
    util-linux
    bzip2
    libgcc
  ];

  system.stateVersion = "25.11"; 

}
