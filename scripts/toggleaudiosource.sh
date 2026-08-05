#!/usr/bin/env bash
#  _____                 _           _             _ _       
# |_   _|__   __ _  __ _| | ___     / \  _   _  __| (_) ___  
#   | |/ _ \ / _` |/ _` | |/ _ \   / _ \| | | |/ _` | |/ _ \ 
#   | | (_) | (_| | (_| | |  __/  / ___ \ |_| | (_| | | (_) |
#   |_|\___/ \__, |\__, |_|\___| /_/   \_\__,_|\__,_|_|\___/ 
#            |___/ |___/                                     
#  ____                           
# / ___|  ___  _   _ _ __ ___ ___ 
# \___ \ / _ \| | | | '__/ __/ _ \
#  ___) | (_) | |_| | | | (_|  __/
# |____/ \___/ \__,_|_|  \___\___|
#
# by Joshua Holmes (2026) 
# ----------------------------------------------------- 
                                
# the name of this changes sometimes, so we get it programmatically
hyprx_prefix="alsa_output.usb-HP__Inc_HyperX_Cloud_II_Wireless_0-00"
hyprx=$(pactl list short sinks | rg ${hyprx_prefix} | cut -f2)

external_speaker="alsa_output.pci-0000_0b_00.4.analog-stereo"

if [[ $(pactl get-default-sink) = "${hyprx}" ]]; then
    pactl set-default-sink "${external_speaker}"
    dunstify "PulseAudio" "Set to external speaker"
else
    pactl set-default-sink "${hyprx}"
    dunstify "PulseAudio" "Set to headphones"
fi
