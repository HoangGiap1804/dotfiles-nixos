#!/usr/bin/env bash

# Dừng script nếu có lỗi xảy ra
set -e

echo "================================================================"
echo "    BẮT ĐẦU CÀI ĐẶT CẤU HÌNH NIXOS (FLAKES) TỪ DOTFILES         "
echo "================================================================"

# Xác định đường dẫn thư mục hiện tại của script
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NIXOS_DIR="$DOTFILES_DIR/nixos"

if [ ! -d "$NIXOS_DIR" ]; then
    echo "❌ Lỗi: Không tìm thấy thư mục cấu hình NixOS tại $NIXOS_DIR"
    exit 1
fi

echo "✅ Thư mục dotfiles: $DOTFILES_DIR"

# 1. Kiểm tra và sao chép hardware-configuration.nix
# Bước này rất quan trọng để phần cứng của máy mới nhận diện đúng
echo ""
echo "-> Kiểm tra hardware-configuration.nix..."
if [ -f "/etc/nixos/hardware-configuration.nix" ]; then
    echo "✅ Đã tìm thấy /etc/nixos/hardware-configuration.nix của hệ thống mới."
    echo "   Đang sao chép vào thư mục dotfiles..."
    cp /etc/nixos/hardware-configuration.nix "$NIXOS_DIR/hardware-configuration.nix"
    echo "✅ Sao chép thành công."
else
    echo "⚠️ Cảnh báo: Không tìm thấy /etc/nixos/hardware-configuration.nix."
    echo "   Bạn có thể đang không chạy trên một bản cài đặt NixOS tiêu chuẩn hoặc chưa tạo config."
    echo "   Sử dụng cấu hình phần cứng có sẵn trong dotfiles."
fi

# 2. Cập nhật Git index cho Flakes
# Nix Flake chỉ có thể đọc được những file đã được track bởi Git.
echo ""
echo "-> Thêm các thay đổi vào Git để Nix Flake có thể đọc..."
cd "$DOTFILES_DIR"
# Thêm file nhưng chưa cần commit
git add .
echo "✅ Đã cập nhật git index."

# 3. Kích hoạt Flakes (nếu hệ thống chưa bật sẵn experimental features)
# Tạo thư mục config cho nix nếu chưa có
mkdir -p ~/.config/nix
if [ ! -f ~/.config/nix/nix.conf ] || ! grep -q "experimental-features" ~/.config/nix/nix.conf; then
    echo "-> Đang bật tính năng Flakes cho người dùng hiện tại..."
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
fi

# 4. Áp dụng cấu hình bằng nixos-rebuild
echo ""
echo "================================================================"
echo "    Đang tiến hành build và apply cấu hình (nixos-rebuild)      "
echo "================================================================"
echo "Lệnh sẽ chạy: sudo nixos-rebuild switch --flake .#nqim"
echo "Hệ thống sẽ yêu cầu mật khẩu sudo của bạn để cài đặt..."
echo ""

# Chạy lệnh rebuild (nqim là tên cấu hình trong flake.nix)
if sudo nixos-rebuild switch --flake "$DOTFILES_DIR/nixos#nqim"; then
    echo ""
    echo "🎉 Cài đặt hoàn tất thành công!"
    echo "================================================================"
    echo "Một số thay đổi như Window Manager (Hyprland), fonts, hoặc dịch vụ hệ thống"
    echo "có thể yêu cầu khởi động lại máy để hoạt động hoàn hảo nhất."
    echo "Bạn có thể khởi động lại bằng lệnh: reboot"
else
    echo ""
    echo "❌ Có lỗi xảy ra trong quá trình build NixOS."
    echo "Vui lòng kiểm tra lại log lỗi ở trên."
    exit 1
fi
