#!/usr/bin/env bash
# -*- coding: utf-8 -*-

declare -A FILES=(
  ["./vimrc"]="$HOME/.vimrc"
  ["./zshrc"]="$HOME/.zshrc"
  ["./tmux.conf"]="$HOME/.tmux.conf"
  ["./gitconfig"]="$HOME/.gitconfig"
  ["./gitignore"]="$HOME/.gitignore"
  ["./i3/config"]="$HOME/.config/i3/config"
  ["./i3/i3blocks/config"]="$HOME/.config/i3blocks/config"
  ["./i3/i3status/config"]="$HOME/.config/i3status/config"
  ["./polybar/config"]="$HOME/.config/polybar/config.ini"
  ["./polybar/launch"]="$HOME/.config/polybar/launch.sh"
  ["./picom/picom.conf"]="$HOME/.config/picom/picom.conf"
  ["./alacritty/alacritty.toml"]="$HOME/.config/alacritty/alacritty.toml"
  ["./dunst/dunstrc"]="$HOME/.config/dunst/dunstrc"
  ["./clang-format"]="$HOME/.clang-format"
  ["./hyprland/hyprland.conf"]="$HOME/.config/hypr/hyprland.conf"
)

for dest in "${!FILES[@]}"; do
  src="${FILES[$dest]}"
  if ! cmp -s "$dest" "$src"; then
    cp -r "$src" "$dest"
    echo "$dest updated"
  fi
done
