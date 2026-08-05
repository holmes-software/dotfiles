#!/usr/bin/env bash
#  _____                 _      
# |_   _|__   __ _  __ _| | ___ 
#   | |/ _ \ / _` |/ _` | |/ _ \
#   | | (_) | (_| | (_| | |  __/
#   |_|\___/ \__, |\__, |_|\___|
#            |___/ |___/        
#  _   _       _   _  __ _           _   _                 
# | \ | | ___ | |_(_)/ _(_) ___ __ _| |_(_) ___  _ __  ___ 
# |  \| |/ _ \| __| | |_| |/ __/ _` | __| |/ _ \| '_ \/ __|
# | |\  | (_) | |_| |  _| | (_| (_| | |_| | (_) | | | \__ \
# |_| \_|\___/ \__|_|_| |_|\___\__,_|\__|_|\___/|_| |_|___/
#
# by Joshua Holmes (2025) 
# ----------------------------------------------------- 

# signal chosen from ~/dotfiles/waybar/config to trigger waybar update
signal_from_config=2

# number retrieved from `kill -l`
SIGRTMIN=34

# calculated signal to actually send to waybar
signal="$(( "${signal_from_config}" + "${SIGRTMIN}" ))"

unpause() {
    dunstctl set-paused false && dunstify "dunst" "Unpausing noties"
}
pause() {
    dunstctl set-paused true
}

if [[ $(dunstctl get-pause-level) == 0 ]]; then
    pause
else
    unpause
fi

waybar_pid="$(pgrep waybar)"

kill -n "${signal}" "${waybar_pid}"
