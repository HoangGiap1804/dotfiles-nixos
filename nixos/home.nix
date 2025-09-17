{ config, pkgs, ... }:

{
  home.username = "nqim";
  home.homeDirectory = "/home/nqim";
  home.stateVersion = "24.05"; # chỉnh theo version NixOS của bạn

  # 🛠 Packages cài cho user
  home.packages = with pkgs; [
    android-studio
    flutter
    android-tools
    temurin-bin-17

    wget
    curl
    htop
    neofetch  
    waybar
    rofi
    hyprpaper
    kitty
    stow
    ripgrep
    clang
    hyprpaper
    unzip
    tmux

    oh-my-posh
    fastfetch

    kdePackages.dolphin

    python3
    python3Packages.pywal
    python3Packages.pip
    libGL
    xorg.libX11
    xorg.libXext
    xorg.libXrender

    nerd-fonts.hack

    # lsp program server
    lua-language-server
    stylua
  ];

  # Có thể thêm config môi trường nếu cần 
    home.sessionVariables = {
        ANDROID_HOME = "${pkgs.android-studio}/share/android-studio";
        ANDROID_SDK_ROOT = "${pkgs.android-studio}/share/android-studio";

        PATH = "${pkgs.flutter}/bin:" + 
            "${pkgs.android-studio}/share/android-studio/emulator:" +
            "${pkgs.android-studio}/share/android-studio/tools:" +
            "${pkgs.android-studio}/share/android-studio/platform-tools:" +
            builtins.getEnv "PATH";
    };
}
