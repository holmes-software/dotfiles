#!/bin/bash
#                _ _                              
# __      ____ _| | |_ __   __ _ _ __   ___ _ __  
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__| 
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |    
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|    
#                   |_|         |_|               
#  
# by Stephan Raabe (2023) 
# ----------------------------------------------------- 

# needs to be the a directory that contains 1 or more images
wallpaper_dir="/mnt/hdd/pictures/wallpaper/from-reddit"

img_cache="${HOME}/.cache/current_wallpaper.jpg"

get_remote_img() {
    remote_url="https://picsum.photos/3440/1440"
    wget -qO "${img_cache}" "${remote_url}"
}

get_random_img() {
    random_img="$(ls -d "${wallpaper_dir}/"*.* | shuf -n 1)"
}

case $1 in

    # Load wallpaper from .cache of last session 
    "init")
        if [ -f "${img_cache}" ]; then
            wallust --skip-sequences run "${img_cache}"
        else
            get_random_img
            wallust --skip-sequences run "${random_img}"
        fi
    ;;

    # Select wallpaper with rofi
    "select")
        selected=$(ls -1 "${wallpaper_dir}" | grep "jpg" | rofi -dmenu -replace -config ~/dotfiles/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wallust --skip-sequences run "${wallpaper_dir}/${selected}"
    ;;

    # Fetch wallpaper from online
    "remote")
        get_remote_img
        wallust --skip-sequences run "${img_cache}"
    ;;

    # Randomly select wallpaper 
    *)
        get_random_img
        wallust --skip-sequences run "${random_img}"
    ;;

esac

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wallust/colors.sh"
echo "Wallpaper: $wallpaper"

# ----------------------------------------------------- 
# Copy selected wallpaper into .cache folder
# ----------------------------------------------------- 
cp "${wallpaper}" "${img_cache}"

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
# transition_type="wipe"
# transition_type="outer"
transition_type="random"

awww clear
awww img "${wallpaper}" \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
~/dotfiles/waybar/scripts/launch.sh

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 
sleep 1
notify-send "Colors and Wallpaper updated" "with image $wallpaper"

echo "DONE!"
