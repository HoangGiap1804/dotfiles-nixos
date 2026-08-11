#!/bin/bash

# Kiểm tra và cài đặt trình quản lý gói AUR (yay) nếu chưa có
if ! command -v yay &> /dev/null; then
    echo "yay chưa được cài đặt. Đang tiến hành cài đặt yay..."
    sudo pacman -Syu --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay || exit
    makepkg -si --noconfirm
    cd - || exit
    rm -rf /tmp/yay
fi

# Cập nhật hệ thống
echo "Cập nhật hệ thống..."
sudo pacman -Syu --noconfirm

# Các gói từ kho chính thức của Arch Linux (cài bằng pacman)
PACMAN_PACKAGES=(
    # System & Utilities
    vim git wget curl htop unzip cpio
    blueman bluez libnotify inotify-tools brightnessctl
    
    # Wayland & Hyprland
    hyprland grim slurp wl-clipboard
    rofi-wayland # thay thế cho rofi trên Wayland
    
    # Terminal & Shell
    kitty neovim ripgrep fzf fastfetch neofetch
    
    # Development tools
    clang cmake meson ninja pkgconf
    docker-compose rust nodejs pnpm
    jdk17-openjdk maven
    
    # Applications
    firefox
    libreoffice-fresh nautilus obs-studio
    openssl blender scrcpy vlc
    
    # Theming & Fonts
    ttf-hack-nerd python-pywal gnome-tweaks arc-gtk-theme gtk3
)

# Các gói từ AUR (cài bằng yay)
AUR_PACKAGES=(
    # Browser
    zen-browser-bin
    
    # Development & IDEs
    visual-studio-code-bin
    intellij-idea-ultimate-edition
    android-studio
    flutter
    lazydocker
    dbeaver
    postman-bin
    stripe-cli
    
    # Shell & UI
    oh-my-posh-bin
    swww
    quickshell-git
    
    # Others
    drawio-desktop
    mission-center
)

echo "Đang cài đặt các gói chính thức bằng pacman..."
sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"

echo "Đang cài đặt các gói từ AUR bằng yay..."
yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"

echo "Quá trình cài đặt hoàn tất!"

# Lưu ý:
# - 'home-manager': Là công cụ của hệ sinh thái Nix, không có trên Arch.
# - 'opencode': Không rõ gói cụ thể trên Arch (có thể là một font hoặc IDE nội bộ), bạn có thể tự cài thủ công nếu cần.
