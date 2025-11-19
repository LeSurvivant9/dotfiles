#!/bin/zsh

# Choix possibles
options="Étendre\nDupliquer (Miroir)\nDP-1 Uniquement\nDP-2 Uniquement"

# Affiche le menu Rofi
choice=$(echo "$options" | rofi -dmenu -p "Affichage")

# Fonction pour recharger l'interface (Waybar + Wallpaper)
reload_ui() {
  # 1. Tuer les processus existants
  pkill waybar
  pkill linux-wallpaperengine

  # 2. Petite pause pour laisser Hyprland appliquer la résolution
  sleep 0.5

  # 3. Relancer Waybar (en arrière-plan)
  waybar &

  # 4. Relancer les Wallpapers (Vos IDs spécifiques)
  # Note: Le & à la fin est important pour ne pas bloquer le script
  linux-wallpaperengine --silent --screen-root DP-1 --bg 1258693441 &
  linux-wallpaperengine --silent --screen-root DP-2 --bg 1143394477 &
}

case $choice in
"Étendre")
  # Config Hyprland
  hyprctl keyword monitor "DP-1,3840x2160@240,0x0,1.6"
  hyprctl keyword monitor "DP-2,2560x1440@240,auto,1"

  # Recharger l'interface pour qu'elle apparaisse sur les deux écrans
  reload_ui
  ;;

"Dupliquer (Miroir)")
  hyprctl keyword monitor "DP-1,3840x2160@240,0x0,1.6"
  hyprctl keyword monitor "DP-2,preferred,auto,1,mirror,DP-1"

  # Pas besoin de reload complet ici, mais on peut restart waybar pour être sûr
  pkill waybar
  sleep 0.5
  waybar &
  ;;

"DP-1 Uniquement")
  hyprctl keyword monitor "DP-1,enable"
  hyprctl keyword monitor "DP-2,disable"
  reload_ui
  ;;

"DP-2 Uniquement")
  hyprctl keyword monitor "DP-1,disable"
  hyprctl keyword monitor "DP-2,enable"
  reload_ui
  ;;
esac
