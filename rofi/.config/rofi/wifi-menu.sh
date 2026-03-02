#!/usr/bin/env bash

# Lấy danh sách Wi-Fi
wifi_list=$(nmcli --fields "SSID,SECURITY,SIGNAL" device wifi list | sed '1d')

# Mở rofi menu
chosen_network=$(echo "$wifi_list" | rofi -dmenu -i -p "Wi-Fi")

# Nếu người dùng nhấn ESC
[ -z "$chosen_network" ] && exit

# Lấy SSID từ dòng chọn
ssid=$(echo "$chosen_network" | awk '{print $1}')

# Kiểm tra mạng có password không
security=$(echo "$chosen_network" | awk '{print $2}')

if [[ "$security" == "--" ]]; then
    # Mạng không mật khẩu
    nmcli device wifi connect "$ssid"
else
    # Nhập mật khẩu qua rofi
    password=$(rofi -dmenu -p "Password for $ssid" -password)
    nmcli device wifi connect "$ssid" password "$password"
fi
