#!/usr/bin/env bash
# -*- coding: utf-8 -*-

DND_STATE=$(dunstctl is-paused)

case "$1" in
    "left")
        if [ "$DND_STATE" = "true" ]; then
            dunstctl set-paused false
        else
            dunstctl set-paused true
        fi
        ;;
esac

if [ "$DND_STATE" = "true" ]; then
    echo "🔕"
else
    echo "🔔"
fi
