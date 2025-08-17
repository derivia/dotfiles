#!/usr/bin/env bash
# -*- coding: utf-8 -*-

declare -A FILES=(
    ["./vimrc"]="$HOME/.vimrc"
    ["./zshrc"]="$HOME/.zshrc"
    ["./zsh_aliases"]="$HOME/.zsh_aliases"
    ["./tmux.conf"]="$HOME/.tmux.conf"
    ["./gitignore"]="$HOME/.gitignore"
    ["./alacritty/alacritty.toml"]="$HOME/.config/alacritty/alacritty.toml"
    ["./dunst/dunstrc"]="$HOME/.config/dunst/dunstrc"
    ["./clang-format"]="$HOME/.clang-format"
    ["./rubocop.yml"]="$HOME/.rubocop.yml"
    ["./xprofile"]="$HOME/.xprofile"
    ["./xinitrc"]="$HOME/.xinitrc"
)

for dest in "${!FILES[@]}"; do
    src="${FILES[$dest]}"
    if ! cmp -s "$dest" "$src"; then
        cp -r "$src" "$dest"
        echo "$dest updated"
    fi
done
