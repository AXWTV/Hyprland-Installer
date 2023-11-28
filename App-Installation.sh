#!/bin/bash

printf "\e[1;37m 
█▀▀ █▀█ █▀▀ ▀█▀ █ █ █ ▄▀▄ █▀█ █▀▀ 
▄██ █▄█ █▀   █  ▀▄▀▄▀ █▀█ █▀▄ ██▄  
                                INSTALL BY AXWTV

make sure to have snapd and flatpak with flathub.
                                                                      
┌──────────────────────────────────────────────────────────────────┐
│ [1]  VS-Code                                                     │
│ [2]  Chrome                                                      │
│ [3]  Firefox                                                     │
│ [4]  Brave                                                       │
│ [5]  Blender                                                     │
│ [6]  Libre Office                                                │
│ [7]  Vlc                                                         │
│ [8]  Flame Shot                                                  │
│ [9]  Discord                                                     │
│ [10] OBS                                                         │
│ [11] Spotify                                                     │
│ [12] KDElive                                                     │
│ [13] Audacity                                                    │
│ [14] GNU Image Manipulation Program                              │
│ [15] Krita                                                       │
│ [16] Obsidian                                                    │
│ [17] AntimicroX                                                  │
│ [0]  Exit                                                        │
└──────────────────────────────────────────────────────────────────┘
\e[0m"
read -rp ' ❯ Enter option: ' OPTION

case "$OPTION" in

1)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub com.visualstudio.code
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

2)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub com.google.Chrome
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

3)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub org.mozilla.firefox
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

4)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub com.brave.Browser
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

5)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub org.blender.Blender
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

6)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub org.libreoffice.LibreOffice
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

7)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub org.videolan.VLC
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

8)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub org.flameshot.Flameshot
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

9)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub com.discordapp.Discord
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

10)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub com.obsproject.Studio
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

11)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub com.spotify.Client
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

12)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub org.kde.kdenlive
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

13)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub org.audacityteam.Audacity
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

14)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub org.gimp.GIMP
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

15)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub org.kde.krita
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

16)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub md.obsidian.Obsidian
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

17)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  flatpak install flathub io.github.antimicrox.antimicrox
  "$SCRIPT_DIR/App-Installation.sh"
  ;;

  
0)
  echo "Exiting"
  ;;

*)
  echo "Invalid command !"
  ;;
esac
