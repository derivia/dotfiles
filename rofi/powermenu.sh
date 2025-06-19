#!/bin/bash

lock="🔒 Lock"
logout="🚪 Logout"
sleep="😴 Sleep"
reboot="🔄 Reboot"
shutdown="⛔ Shutdown" 

selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu\
    -i\
    -p "Menu"\
    -config "~/.config/rofi/config.rasi"\
    -width "15"\
    -lines 5\
    -theme-str 'window {location: center; anchor: center;}'\
    -theme-str 'listview {border: 0px;}'\
    -theme-str 'mainbox {border: 0px;}'
)

if [ "$selected_option" == "$lock" ]
then
    hyprlock
elif [ "$selected_option" == "$logout" ]
then
    hyprctl dispatch exit 0
elif [ "$selected_option" == "$shutdown" ]
then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    systemctl reboot
elif [ "$selected_option" == "$sleep" ]
then
    systemctl suspend
else
    echo "No match"
fi
