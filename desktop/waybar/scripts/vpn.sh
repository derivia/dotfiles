#!/usr/bin/env bash
# -*- coding: utf-8 -*-

GREEN="#a8e6cf"
RED="#ff8b94"

if ip addr show tun0 2>/dev/null | grep -q "state UP"; then
    TUN_STATUS="<span foreground='$GREEN'>tun0</span>"
else
    TUN_STATUS="<span foreground='$RED'>tun0</span>"
fi

if ip addr show suica 2>&1 | grep -qv "does not exist"; then
    PROTON_STATUS="<span foreground='$GREEN'>proton</span>"
else
    PROTON_STATUS="<span foreground='$RED'>proton</span>"
fi

if ip addr show ppp0 2>&1 | grep -qv "does not exist"; then
    PPP_STATUS="<span foreground='$GREEN'>ppp0</span>"
else
    PPP_STATUS="<span foreground='$RED'>ppp0</span>"
fi

echo "$TUN_STATUS | $PROTON_STATUS | $PPP_STATUS"
