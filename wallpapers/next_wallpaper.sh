#!/usr/bin/env bash

LIST="$HOME/.dotfiles/wallpapers/list.txt"
STATE="$HOME/.dotfiles/wallpapers/state"

# Nếu chưa có state thì bắt đầu từ ảnh đầu
if [ ! -f "$STATE" ]; then
  echo 0 > "$STATE"
fi

INDEX=$(cat "$STATE")
TOTAL=$(wc -l < "$LIST")

# Lấy đường dẫn ảnh
IMG=$(sed -n "$((INDEX + 1))p" "$LIST")

# Nếu vượt quá số ảnh → quay lại đầu
if [ -z "$IMG" ]; then
  INDEX=0
  IMG=$(sed -n "1p" "$LIST")
fi

# Đổi wallpaper bằng swww
swww img "$IMG" \
  --transition-type wipe \
  --transition-duration 1 \
  --transition-fps 60

# Lưu index tiếp theo
echo $((INDEX + 1)) > "$STATE"
