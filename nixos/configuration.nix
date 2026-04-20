{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nqim"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-unikey     # Gõ tiếng Việt
      fcitx5-gtk
      fcitx5-configtool # Giao diện cấu hình
    ];
  };

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice"; # hoặc "Bibata-Modern-Amber"
    XCURSOR_SIZE = "24";
    XDG_SESSION_TYPE="wayland";
    GDK_BACKEND="wayland,x11";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true; 
    };
  };

  services.upower.enable = true;

  services.udisks2.enable = true;     # Quản lý ổ đĩa
  services.gvfs.enable = true;        # Cung cấp mount tự động cho file manager
  services.devmon.enable = true;      # Tự động mount thiết bị

  programs.hyprland.enable = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  services.blueman.enable = true;   # Enables the Blueman manager
  hardware.bluetooth.enable = true; # Enables Bluetooth support
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;

    open = false; # dùng driver proprietary

    nvidiaSettings = true;
  };
  hardware.nvidia.prime = {
    sync.enable = true;

    intelBusId = "PCI:0:2:0";   # check bằng lspci
    nvidiaBusId = "PCI:1:0:0";  # check bằng lspci
  };
  hardware.opengl.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nqim = {
    isNormalUser = true;
    description = "nqim";
    extraGroups = [ 
      "networkmanager"
      "wheel" 
      "storage" 
      "plugdev" 
      "disk"
      "adbusers"
      "kvm"
    ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    stow
    docker-compose
    fcitx5-unikey
    maven
    gradle
    hyprlock
    bibata-cursors
    nodejs_24
    pnpm_9
  ];
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 3000 8000 8765];
  };


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

  system.stateVersion = "25.05"; 

}
