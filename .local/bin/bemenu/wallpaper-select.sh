#!/usr/bin/env bash

# Set your wallpaper directory path
: "$WALLPAPER_DIR:=$HOME/Pictures/backgrounds}"

# Find image files, pipe into bemenu
file=$(find "$WALLPAPER_DIR" -type f \
    | sed "s|^$WALLPAPER_DIR/||" \
    | bemenu $@)

# If a wallpaper was chosen, set it via awww
if [ -n "$file" ]; then
    wallpaper="$WALLPAPER_DIR/$file"
    awww img "$wallpaper"
    wallust run -s -q "$wallpaper" ||
    wallust run -s -q --backend wal "$wallpaper"
    killall -SIGUSR2 waybar
fi
