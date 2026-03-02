#!/usr/bin/env bash

LIST="$HOME/.dotfiles/wallpapers/list.txt"
STATE="$HOME/.dotfiles/wallpapers/state"

# Nếu chưa có state → bắt đầu từ ảnh cuối
if [ ! -f "$STATE" ]; then
  TOTAL=$(wc -l < "$LIST")
  echo "$((TOTAL - 1))" > "$STATE"
fi

INDEX=$(cat "$STATE")
TOTAL=$(wc -l < "$LIST")

# Giảm index
INDEX=$((INDEX - 1))

# Nếu nhỏ hơn 0 → quay về ảnh cuối
if [ "$INDEX" -lt 0 ]; then
  INDEX=$((TOTAL - 1))
fi

IMG=$(sed -n "$((INDEX + 1))p" "$LIST")

# Đổi wallpaper
swww img "$IMG" \
  --transition-type wipe \
  --transition-duration 1 \
  --transition-fps 60

# Lưu lại index
echo "$INDEX" > "$STATE"
