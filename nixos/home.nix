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
    fzf
    bat

    pywal

    oh-my-posh
    fastfetch

    kdePackages.dolphin

    quickshell

    nerd-fonts.hack

    # lsp program server
    lua-language-server
    stylua
    mysql-workbench

    nodejs_20
    postman
    swww
  ];

    home.sessionVariables = {
    # Có thể thêm config môi trường nếu cần 
        ANDROID_HOME = "${pkgs.android-studio}/share/android-studio";
        ANDROID_SDK_ROOT = "${pkgs.android-studio}/share/android-studio";

        PATH = "${pkgs.flutter}/bin:" + 
            "${pkgs.android-studio}/share/android-studio/emulator:" +
            "${pkgs.android-studio}/share/android-studio/tools:" +
            "${pkgs.android-studio}/share/android-studio/platform-tools:" +
            builtins.getEnv "PATH";
    };
}
