{ config, pkgs, inputs, ... }:

{
  home.username = "nqim"; home.homeDirectory = "/home/nqim";
  home.stateVersion = "25.11"; # chỉnh theo version NixOS của bạn

  home.file.".tmux.conf".source = ./config/tmux/.tmux.conf;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/quickshell".source = ./config/topbar-quickshell;
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

  # nqim OS theme — KDE/Dolphin
  home.file.".config/kdeglobals".source = ./config/nqim-theme/kde/kdeglobals;
  home.file.".config/darklyrc".source = ./config/nqim-theme/kde/darklyrc;
  home.file.".local/share/color-schemes/nqim.colors".source =
    ./config/nqim-theme/kde/color-schemes/nqim.colors;

  # nqim icon theme (dark squircle folders)
  home.file.".local/share/icons/nqim" = {
    source = ./config/nqim-theme/icons/nqim;
    recursive = true;
  };

  # Dolphin settings (nqim OS style)
  home.file.".config/dolphinrc".text = ''
    [General]
    GlobalViewProps=true
    ShowFullPath=true
    ShowStatusBar=FullWidth

    [MainWindow]
    MenuBar=Disabled

    [IconsMode]
    IconSize=96
    PreviewSize=128

    [PlacesPanel]
    IconSize=28

    [DetailsMode]
    PreviewSize=22

    [InformationPanel]
    previewsShown=true
    showHovered=true

    [PreviewSettings]
    Plugins=appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,fontthumbnail,gsthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,magiclanternthumbnail,mobithumbnail,moviethumbnail,msthumbnail,opendocumentthumbnail,pdfthumbnail,svgthumbnail,windowsexethumbnail,windowsimagethumbnail,xdgthumbnail,rawthumbnail

    [UiSettings]
    ColorScheme=nqim
  '';

  qt = {
    enable = true;
    platformTheme.name = "kde";
  };

  # Portal config — file picker uses KDE (Dolphin) then GTK fallback
  home.file.".config/xdg-desktop-portal/hyprland-portals.conf".source =
    ./config/nqim-theme/xdg-desktop-portal/hyprland-portals.conf;

  programs.git = {
    enable = true;
    userName = "Nguyen Van Hoang Giap";
    userEmail = "hgiap1804@gmail.com";
  };

  programs.ssh = {
    enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "nqim";
      font-name = "Inter Variable 10";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "nqim";
      package = pkgs.papirus-icon-theme;  # fallback via Inherits
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    gtk3.extraCss = builtins.readFile ./config/nqim-theme/gtk/gtk-3.0/gtk.css;
    gtk4.extraCss = builtins.readFile ./config/nqim-theme/gtk/gtk-4.0/gtk.css;
    gtk4.theme = config.gtk.theme;
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  # 🛠 Packages cài cho user
  home.packages = with pkgs; [
    wget
    curl
    htop
    fastfetch
    rofi
    kitty
    ripgrep
    unzip
    fzf
    pywal
    fastfetch
    quickshell
    nerd-fonts.hack
    maple-mono.NF                # Maple Mono NF (monospace)
    inter                        # Inter Variable font (nqim OS)
    awww
    jetbrains.idea
    lazydocker
    vscode
    postman
    drawio
    libreoffice
    # nautilus  # replaced by Dolphin

    # Dolphin archive integration (right-click extract/compress)
    kdePackages.ark              # GUI + Dolphin context menu
    libarchive                   # tar.gz, tar.bz2, tar.xz, tar.zst
    p7zip                        # .7z
    zip                          # create .zip
    unrar                        # .rar (unfree)
    openssl
    mission-center
    brightnessctl
    # C/C++ development & build tools
    gcc
    gnumake
    clang-tools
    bear
    gdb
    valgrind
    python3

    # Flutter development
    flutter
    android-studio
    cmake
    ninja
    pkg-config
    gtk3
    cargo

    gnome-tweaks
    arc-theme

    nodejs_22
    pnpm 

    scrcpy

    jdk17
    maven
    dbeaver-bin

    libnotify
    inotify-tools
    envsubst

    # Hyprland lock screen
    hyprlock
    hypridle

    google-chrome

    # PHP & Laravel
    php
    phpPackages.composer
  ];

}
