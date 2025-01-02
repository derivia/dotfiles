#!/usr/bin/env bash
# -*- coding: utf-8 -*-

declare -A FILES=(
  ["./vimrc"]="$HOME/.vimrc"
  ["./zshrc"]="$HOME/.zshrc"
  ["./tmux.conf"]="$HOME/.tmux.conf"
  ["./gitconfig"]="$HOME/.gitconfig"
  ["./gitignore"]="$HOME/.gitignore"
  ["./i3/config"]="$HOME/.config/i3/config"
  ["./i3/i3status/config"]="$HOME/.config/i3status/config"
  ["./alacritty/alacritty.toml"]="$HOME/.config/alacritty/alacritty.toml"
  ["./dunst/dunstrc"]="$HOME/.config/dunst/dunstrc"
)

for dest in "${!FILES[@]}"; do
  src="${FILES[$dest]}"
  if ! cmp -s "$dest" "$src"; then
    cp -r "$src" "$dest"
    echo "$(basename "$dest") updated"
  fi
done
