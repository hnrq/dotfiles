!#/bin/sh
wallust run $1

# Reload applications
makoctl reload &
notify-send "Theme updated"
