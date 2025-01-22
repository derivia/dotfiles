#!/usr/bin/env bash
# -*- coding: utf-8 -*-

POMODORO_FILE="/tmp/pomodoro-polybar"
WORK_MINUTES=45
BREAK_MINUTES=10
WORK_MSG="Time to work!"
BREAK_MSG="Time for a break..."

if [[ -f "$POMODORO_FILE" ]]; then
    . "$POMODORO_FILE"
else
    STATE="stopped"
    MODE="work"
    SECONDS_LEFT=$((WORK_MINUTES * 60))
fi

update_file() {
    echo "STATE=$STATE" > "$POMODORO_FILE"
    echo "MODE=$MODE" >> "$POMODORO_FILE"
    echo "SECONDS_LEFT=$SECONDS_LEFT" >> "$POMODORO_FILE"
}

case "$1" in
    "left")
        if [[ "$STATE" == "running" ]]; then
            STATE="paused"
        else
            STATE="running"
        fi
        ;;
    "right")
        STATE="stopped"
        MODE="work"
        SECONDS_LEFT=$((WORK_MINUTES * 60))
        ;;
esac

if [[ "$STATE" == "running" ]]; then
    if ((SECONDS_LEFT > 0)); then
        SECONDS_LEFT=$((SECONDS_LEFT - 1))
    else
        if [[ "$MODE" == "work" ]]; then
            MODE="break"
            SECONDS_LEFT=$((BREAK_MINUTES * 60))
            notify-send 'POMODORO 🏖️' "$BREAK_MSG"
        else
            MODE="work"
            SECONDS_LEFT=$((WORK_MINUTES * 60))
            notify-send 'POMODORO 💼' "$WORK_MSG"
        fi
    fi
fi

update_file

MINUTES=$((SECONDS_LEFT / 60))
SECONDS=$((SECONDS_LEFT % 60))

case "$STATE" in
    "stopped")
        COLOR="#AF2032" # red
        ;;
    "paused")
        COLOR="#CF9500" # yellow
        ;;
    "running")
        COLOR="#328A42" # green
        ;;
    *)
        COLOR="#FFFFFF" # white as fallback
        ;;
esac

echo "%{F$COLOR}Pomodoro: $(printf "%02d:%02d" "$MINUTES" "$SECONDS") %{F-}"
