#!/usr/bin/env bash
# -*- coding: utf-8 -*-

VIMRCSTAT="$(cmp --silent "./vimrc" "$HOME/.vimrc"; echo $?)"
ZSHRCSTAT="$(cmp --silent "./zshrc" "$HOME/.zshrc"; echo $?)"
TMUXSTAT="$(cmp --silent "./tmux.conf" "$HOME/.tmux.conf"; echo $?)"
GCSTAT="$(cmp --silent "./gitconfig" "$HOME/.gitconfig"; echo $?)"
GIGNSTAT="$(cmp --silent "./gitignore" "$HOME/.gitignore"; echo $?)"
I3STAT="$(cmp --silent "./i3/config" "$HOME/.config/i3/config"; echo $?)"
I3BARSTAT="$(cmp --silent "./i3/i3status/config" "$HOME/.config/i3status/config"; echo $?)"
I3BLKSTAT="$(cmp --silent "./i3/i3blocks/config" "$HOME/.config/i3blocks/config"; echo $?)"
ALACSTAT="$(cmp --silent "./alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"; echo $?)"
DUNSTSTAT="$(cmp --silent "./dunst/dunstrc" "$HOME/.config/dunst/dunstrc"; echo $?)"

if [[ $GCSTAT -ne 0 ]]; then
  cp "$HOME/.gitconfig" ./gitconfig
  echo "gitconfig updated"
fi

if [[ $GIGNSTAT -ne 0 ]]; then
  cp "$HOME/.gitignore" ./gitignore
  echo "gitignore updated"
fi

if [[ $VIMRCSTAT -ne 0 ]]; then
  cp "$HOME/.vimrc" ./vimrc
  echo "vimrc updated"
fi

if [[ $ZSHRCSTAT -ne 0 ]]; then
  cp "$HOME/.zshrc" ./zshrc
  echo "zshrc updated"
fi

if [[ $TMUXSTAT -ne 0 ]]; then
  cp "$HOME/.tmux.conf" ./tmux.conf
  echo "tmux.conf updated"
fi

if [[ $I3STAT -ne 0 ]]; then
  cp "$HOME/.config/i3/config" ./i3/config
  echo "i3 config updated"
fi

if [[ $I3BARSTAT -ne 0 ]]; then
  cp "$HOME/.config/i3status/config" ./i3/i3status/config
  echo "i3bar config updated"
fi

if [[ $I3BLKSTAT -ne 0 ]]; then
  rm -rf ./i3/i3blocks
  cp -r "$HOME/.config/i3blocks" ./i3
  echo "i3blocks updated"
fi

if [[ $ALACSTAT -ne 0 ]]; then
  cp "$HOME/.config/alacritty/alacritty.toml" ./alacritty/alacritty.toml
  echo "alacritty.toml updated"
fi

if [[ $DUNSTSTAT -ne 0 ]]; then
  cp "$HOME/.config/dunst/dunstrc" ./dunst/dunstrc
  echo "dunstrc updated"
fi
