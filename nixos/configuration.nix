{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/network.nix
      ./modules/users.nix
      ./modules/nvidia.nix
      ./modules/fish.nix
      ./modules/window_manager.nix
      ./modules/properties.nix
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
