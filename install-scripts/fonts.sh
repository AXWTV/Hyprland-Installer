#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# FONTS #

fonts=(
adobe-source-code-pro-fonts
fira-code-fonts
fontawesome-fonts-all
google-droid-sans-fonts
google-noto-sans-cjk-fonts
google-noto-color-emoji-fonts
google-noto-emoji-fonts
jetbrains-mono-fonts
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_fonts.log"

# Installation of main components
printf "\n%s - Installing necessary fonts.... \n" "${NOTE}"

for PKG1 in "${fonts[@]}"; do
  install_package "$PKG1" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 install had failed, please check the install.log"
    exit 1
  fi
done


fonts=(
  "Hack"
  "Iosevka"
  "NerdFontsSymbolsOnly"
  "JetBrainsMono"
)

# Get the latest release tag from the Nerd Fonts repository
latest_release_tag=$(curl --silent "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')

# Download and install fonts
for font in "${fonts[@]}"
do
  if [ -d ~/.local/share/fonts/${fonts} ]; then
      rm -rf ~/.local/share/fonts/${fonts} 2>&1 | tee -a "$LOG"
  fi

  mkdir -p ~/.local/share/fonts/${fonts} 2>&1 | tee -a "$LOG"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/${latest_release_tag}/${fonts}.zip 2>&1 | tee -a "$LOG"
  unzip ${fonts}.zip -d ~/.local/share/fonts/${fonts} 2>&1 | tee -a "$LOG"
  
  if [ -d "${fonts}.zip" ]; then
  	  rm -r ${fonts}.zip 2>&1 | tee -a "$LOG"
  fi
done

# Update font cache
fc-cache -fv

clear
