!#/bin/sh
wallust run $1

# Reload applications
makoctl reload & $HOME/.config/waybar/launch.sh
notify-send "Theme updated"
