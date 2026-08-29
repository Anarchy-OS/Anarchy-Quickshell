#!/bin/sh
set -eu

CACHE_FOLDER="$HOME/.config/anarchy/cache"
BLURRED_WALLPAPER="$CACHE_FOLDER/blurred_wallpaper.png"
SQUARE_WALLPAPER="$CACHE_FOLDER/square_wallpaper.png"
LOG_FILE="$CACHE_FOLDER/change-wallpaper.log"

mkdir -p "$CACHE_FOLDER"
exec >"$LOG_FILE" 2>&1

HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
case "$1" in
  "$HOME"/*) WALL_DISPLAY="\$HOME${1#"$HOME"}" ;;
  *) WALL_DISPLAY="$1" ;;
esac
{
  printf '%s\n' "\$wall = $WALL_DISPLAY"
  tail -n +2 "$HYPRLOCK_CONF"
} >"$HYPRLOCK_CONF.tmp"
mv "$HYPRLOCK_CONF.tmp" "$HYPRLOCK_CONF"

qs ipc call wallpaper toggle
awww img "$1"
matugen image "$1" --source-color-index 0 -m "dark"

cp "$1" "$BLURRED_WALLPAPER.tmp"
cp "$1" "$SQUARE_WALLPAPER.tmp"

magick "$BLURRED_WALLPAPER.tmp" -resize 75% "$BLURRED_WALLPAPER.tmp"
magick "$BLURRED_WALLPAPER.tmp" -blur "50x30" "$BLURRED_WALLPAPER.tmp"

magick "$SQUARE_WALLPAPER.tmp" -gravity Center -extent 1:1 "$SQUARE_WALLPAPER.tmp"

mv "$BLURRED_WALLPAPER.tmp" "$BLURRED_WALLPAPER"
mv "$SQUARE_WALLPAPER.tmp" "$SQUARE_WALLPAPER"
