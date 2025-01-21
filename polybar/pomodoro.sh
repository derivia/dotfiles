#!/usr/bin/env bash
# -*- coding: utf-8 -*-

POMODORO_FILE="/tmp/pomodoro-polybar"
WORK_MINUTES=45
BREAK_MINUTES=8
WORK_MSG="Time to work!"
BREAK_MSG="Time for a break!"

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

# Handle timer updates
if [[ "$STATE" == "running" ]]; then
    if ((SECONDS_LEFT > 0)); then
        SECONDS_LEFT=$((SECONDS_LEFT - 1))
    else
        if [[ "$MODE" == "work" ]]; then
            MODE="break"
            SECONDS_LEFT=$((BREAK_MINUTES * 60))
            notify-send "$BREAK_MSG"
        else
            MODE="work"
            SECONDS_LEFT=$((WORK_MINUTES * 60))
            notify-send "$WORK_MSG"
        fi
    fi
fi

update_file

MINUTES=$((SECONDS_LEFT / 60))
SECONDS=$((SECONDS_LEFT % 60))

# Make it colored
case "$STATE" in
    "stopped")
        COLOR="#CF1020"
        ;;
    "paused")
        COLOR="#EFA500"
        ;;
    "running")
        if [[ "$MODE" == "work" ]]; then
            COLOR="#12AA42"
        else
            COLOR="#1E90FF"
        fi
        ;;
    *)
        COLOR="#FFFFFF"
        ;;
esac

printf "%02d:%02d\n%s\n%s\n" "$MINUTES" "$SECONDS" "$MODE" "$COLOR"
