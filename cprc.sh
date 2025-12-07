#!/usr/bin/env bash
# -*- coding: utf-8 -*-

declare -A FILES=(
    ["./configs/vimrc"]="$HOME/.vimrc"
    ["./configs/zshrc"]="$HOME/.zshrc"
    ["./configs/zsh_aliases"]="$HOME/.zsh_aliases"
    ["./configs/tmux.conf"]="$HOME/.tmux.conf"
    ["./configs/gitignore"]="$HOME/.gitignore"
    ["./configs/clang-format"]="$HOME/.clang-format"
    ["./configs/rubocop.yml"]="$HOME/.rubocop.yml"
    ["./configs/pack_ignore"]="$HOME/.pack_ignore"
    ["./desktop/dunst/dunstrc"]="$HOME/.config/dunst/dunstrc"
    ["./desktop/alacritty/alacritty.toml"]="$HOME/.config/alacritty/alacritty.toml"
    ["./desktop/xprofile"]="$HOME/.xprofile"
    ["./desktop/xinitrc"]="$HOME/.xinitrc"
)

for dest in "${!FILES[@]}"; do
    src="${FILES[$dest]}"
    if ! cmp -s "$dest" "$src"; then
        cp -r "$src" "$dest"
        echo "$dest updated"
    fi
done
