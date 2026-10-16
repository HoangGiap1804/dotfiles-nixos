{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/properties.nix   # Timezone, locale, fcitx5 (gõ tiếng Việt)
    ../../modules/fish.nix         # Fish shell
    ../../modules/tmux.nix         # Tmux
  ];

  # ── Bootloader ─────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── Network ────────────────────────────────────────────────────────────────
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };

  # ── KDE Plasma 6 ───────────────────────────────────────────────────────────
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
  };

  # ── Audio (PipeWire) ───────────────────────────────────────────────────────
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ── Bluetooth ──────────────────────────────────────────────────────────────
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # ── Disk / USB automount ───────────────────────────────────────────────────
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.devmon.enable = true;
  services.upower.enable = true;

  # ── Printing (CUPS) ────────────────────────────────────────────────────────
  services.printing.enable = true;

  # ── User ───────────────────────────────────────────────────────────────────
  users.users.basiclaptop = {
    isNormalUser = true;
    description = "Basic Laptop User";
    extraGroups = [
      "networkmanager"
      "wheel"
      "storage"
      "plugdev"
      "disk"
      "video"
      "audio"
    ];
    shell = pkgs.fish;
  };
  users.defaultUserShell = pkgs.fish;

  # ── Packages ───────────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    home-manager
    google-chrome
    libreoffice
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kate          # Text editor của KDE
    kdePackages.gwenview      # Image viewer
    kdePackages.okular        # PDF viewer
    kdePackages.spectacle     # Screenshot tool
    kdePackages.kinfocenter   # System info
    blueman
    htop
    p7zip
    unzip
    zip
  ];

  # ── nix-ld (chạy binary không cần patchelf) ────────────────────────────────
  programs.nix-ld.enable = true;

  system.stateVersion = "25.11";
}
