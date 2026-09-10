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

  # ── Swap & Memory Optimization (24GB RAM) ──────────────────────────────
  # Tiered swap: zram (tầng 1, nhanh) → swapfile (tầng 2, fallback)
  # Linux tự động dùng theo priority: cao hơn → được dùng trước

  # Tầng 1: zram — swap nén ngay trong RAM, tốc độ cao, ưu tiên 100 (mặc định)
  zramSwap = {
    enable = true;
    algorithm = "zstd";       # Nhanh + tỉ lệ nén tốt nhất
    memoryPercent = 25;       # ~6GB zram (25% × 24GB)
  };

  # Tầng 2: swapfile — fallback ra ổ đĩa, chỉ dùng khi zram hết
  swapDevices = [{
    device   = "/swapfile";
    size     = 4 * 1024;     # 4GB — đủ làm lưới an toàn, không tốn quá nhiều
    priority = 0;            # Ưu tiên thấp hơn zram (100) → dùng sau cùng
  }];

  # Kernel VM tuning
  boot.kernel.sysctl = {
    # Tránh dùng swap sớm khi còn nhiều RAM (0–100, thấp = ít swap hơn)
    "vm.swappiness"             = 10;
    # Giảm áp lực xóa cache file — giữ cache lâu hơn cho trải nghiệm mượt
    "vm.vfs_cache_pressure"     = 50;
    # Tối ưu dirty page writeback — tránh giật khi flush dữ liệu ra đĩa
    "vm.dirty_ratio"            = 10;
    "vm.dirty_background_ratio" = 5;
  };

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
