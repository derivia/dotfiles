#!/usr/bin/env bash
# -*- coding: utf-8 -*-

VIMRCSTAT="$(cmp --silent "./vimrc" "$HOME/.vimrc"; echo $?)"
ZSHRCSTAT="$(cmp --silent "./zshrc" "$HOME/.zshrc"; echo $?)"
TMUXSTAT="$(cmp --silent "./tmux.conf" "$HOME/.tmux.conf"; echo $?)"
GCSTAT="$(cmp --silent "./gitconfig" "$HOME/.gitconfig"; echo $?)"
I3STAT="$(cmp --silent "./i3/config" "$HOME/.config/i3/config"; echo $?)"
I3BARSTAT="$(cmp --silent "./i3/i3status/config" "$HOME/.config/i3status/config"; echo $?)"
ALACSTAT="$(cmp --silent "./alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"; echo $?)"


if [[ $GCSTAT -ne 0 ]]; then
  cp "$HOME/.gitconfig" ./gitconfig
  echo "gitconfig updated"
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

if [[ $ALACSTAT -ne 0 ]]; then
  cp "$HOME/.config/alacritty/alacritty.toml" ./alacritty/alacritty.toml
  echo "alacritty.toml updated"
fi
