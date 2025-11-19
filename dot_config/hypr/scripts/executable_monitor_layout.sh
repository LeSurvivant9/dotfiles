#!/bin/zsh

# Choix possibles
choices="Étendre\nDupliquer (Miroir)\nDP-1 Uniquement\nDP-2 Uniquement"

# Affiche le menu Rofi
choice=$(echo "$choices" | rofi -dmenu -p "Affichage")

move_workspaces() {
    FROM_MONITOR=$1
    TO_MONITOR=$2

    workspaces=$(hyprctl workspaces -j | jq -r ".[] | select(.monitor == \"$FROM_MONITOR\") | .id")

    for ws in $(echo $workspaces); do
        hyprctl dispatch moveworkspacetomonitor $ws $TO_MONITOR
    done
}

reload_ui() {
  pkill waybar
  pkill linux-wallpaperengine
  sleep 1
  waybar &
  linux-wallpaperengine --silent --screen-root DP-1 --bg 1258693441 &
  linux-wallpaperengine --silent --screen-root DP-2 --bg 1143394477 &
}

case $choice in
"Étendre")
  hyprctl keyword monitor "DP-1,3840x2160@240,0x0,1.6"
  hyprctl keyword monitor "DP-2,2560x1440@240,auto,1"
  reload_ui
  ;;

"Dupliquer (Miroir)")
  hyprctl keyword monitor "DP-1,3840x2160@240,0x0,1.6"
  hyprctl keyword monitor "DP-2,preferred,auto,1,mirror,DP-1"
  pkill waybar
  sleep 0.5
  waybar &
  ;;

"DP-1 Uniquement")
  hyprctl keyword monitor "DP-1,3840x2160@240,0x0,1.6"
  move_workspaces "DP-2" "DP-1"
  hyprctl keyword monitor "DP-2,disable"
  reload_ui
  ;;

"DP-2 Uniquement")
  hyprctl keyword monitor "DP-2,2560x1440@240,auto,1"
  move_workspaces "DP-1" "DP-2"
  hyprctl keyword monitor "DP-1,disable"
  reload_ui
  ;;
esac
