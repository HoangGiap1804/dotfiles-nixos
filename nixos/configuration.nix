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
    # CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";
    # PATH = "${pkgs.cudaPackages.cudatoolkit}/bin:$PATH";
    # LIBRARY_PATH = "/usr/lib:/usr/lib64";
    # EXTRA_LDFLAGS = "-L/lib -L/usr/lib";
    # EXTRA_CCFLAGS = "-I/usr/include";
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
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16; # hoặc postgresql_15 nếu muốn
    dataDir = "/var/lib/postgresql/16"; # nơi lưu database
    authentication = pkgs.lib.mkForce ''
        local all all trust
        host all all 127.0.0.1/32 trust
        host all all ::1/128 trust
    '';
    extensions = ps: with ps; [
      postgis
    ];
  };
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
    waybar
    wofi
    kitty
    grim
    slurp
    wl-clipboard
    firefox
    google-chrome
    neovim
    blueman
    bluez
    home-manager
    stow
    docker-compose
    fcitx5-unikey
    awscli
    maven
    gradle
    hyprlock
    bibata-cursors

    nodejs_24
    pnpm_9

    python3
    python3Packages.pip

    (buildFHSEnv {
      name = "cuda-fhs"; # Tên lệnh bạn sẽ gõ trong terminal

      # Khai báo các gói phần mềm có mặt trong môi trường này
      targetPkgs = pkgs: with pkgs; [
        gcc
        gnumake
        pkg-config
        cmake

        cudaPackages.cudatoolkit
        cudaPackages.cuda_nvcc
        cudaPackages.cuda_cudart
        cudaPackages.cuda_cudart.static
        linuxPackages.nvidia_x11 # Cần thiết để link với driver đồ họa
        
        zlib
        glfw
        glm
        glew.dev
        libglvnd.dev
        libGLU.dev
        xorg.libX11
        xorg.libXrandr
        xorg.libXinerama
        xorg.libXcursor
        xorg.libXi
        nlohmann_json
        
      ];

      # Chạy bash shell khi gọi lệnh này
      runScript = "bash";

      # Khởi tạo các biến môi trường tự động khi vào FHS
      profile = ''
        export CUDA_PATH=${pkgs.cudaPackages.cudatoolkit}
        export PATH=$CUDA_PATH/bin:$PATH
        export LIBRARY_PATH=/usr/lib:/usr/lib64:$LIBRARY_PATH
        export EXTRA_LDFLAGS="-L/lib -L/usr/lib"
        export EXTRA_CCFLAGS="-I/usr/include"
      '';
    })

    # android-studio
    # clang
    # cmake
    # flutter
    # ninja
    # pkg-config

  ];

  # programs = {
  #   adb.enable = true;
  # };
  #
  # system.userActivationScripts = {
  #   stdio = {
  #     text = ''
  #     rm -f ~/Android/Sdk/platform-tools/adb
  #     ln -s /run/current-system/sw/bin/adb ~/Android/Sdk/platform-tools/adb
  #     '';
  #     deps = [
  #     ];
  #   };
  # };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 3000 ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
