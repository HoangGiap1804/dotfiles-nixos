{ config, pkgs, inputs, ... }:

{
  home.username = "basiclaptop";
  home.homeDirectory = "/home/basiclaptop";
  home.stateVersion = "25.11";

  # ── Git ────────────────────────────────────────────────────────────────────
  programs.git = {
    enable = true;
    userName = "basiclaptop";
    userEmail = "";   # điền email của bạn
  };

  programs.ssh.enable = true;

  # ── GTK (dark mode) ────────────────────────────────────────────────────────
  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };
    cursorTheme = {
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
    };
  };

  home.pointerCursor = {
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 24;
    gtk.enable = true;
  };

  # ── Packages ───────────────────────────────────────────────────────────────
  home.packages = with pkgs; [
    # Tiện ích cơ bản
    wget
    curl
    htop
    ripgrep
    unzip
    fzf

    # Font
    nerd-fonts.hack
    inter

    # Shell
    oh-my-posh

    # Archive
    kdePackages.ark
    libarchive
    p7zip
    zip
    unrar
  ];
}
