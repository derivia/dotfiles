#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# kill polybar and launch another one
if pgrep -x polybar; then
	pkill polybar
  polybar &
else
  polybar &
fi
