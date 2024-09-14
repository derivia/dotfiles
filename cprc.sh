#!/usr/bin/env bash
# -*- coding: utf-8 -*-

VIMRCSTAT="$(cmp --silent "./vimrc" "$HOME/.vimrc"; echo $?)"
ZSHRCSTAT="$(cmp --silent "./zshrc" "$HOME/.zshrc"; echo $?)"
TMUXSTAT="$(cmp --silent "./tmux.conf" "$HOME/.tmux.conf"; echo $?)"

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
