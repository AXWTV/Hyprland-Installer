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

source "${SCRIPT_DIR}/Global_functions.sh"

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

# List of available Nerd Fonts
declare -a fonts=(
    "FiraCode"
    "Hack"
    "JetBrainsMono"
    "Mononoki"
    "SourceCodePro"
    "UbuntuMono"
    "DejaVuSansMono"
    "NotoSansMono"
    "Meslo"
    "Iosevka"
    "CaskaydiaCove"
    "Overpass"
    "VictorMono"
    "Symbols Nerd Font"
    "FontAwesome"
    "MaterialIcons"
    "PowerlineSymbols"
)

# Function to display available fonts
function display_fonts() {
    echo "Available Nerd Fonts (separate multiple choices with spaces):"
    for i in "${!fonts[@]}"; do
        echo "$((i + 1)). ${fonts[i]}"
    done
}

# Function to install the selected fonts
function install_fonts() {
    local font_names=("$@")
    local font_dir="$HOME/.local/share/fonts"

    # Create font directory if it doesn't exist
    mkdir -p "$font_dir"

    for font_name in "${font_names[@]}"; do
        echo "Installing $font_name..."
        curl -L "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font_name}.zip" -o "${font_name}.zip"
        unzip -o "${font_name}.zip" -d "$font_dir"
        rm "${font_name}.zip"
    done

    # Update font cache
    fc-cache -f -v

    echo "Selected fonts installed successfully!"
}

# Main script execution
echo "Welcome to the Nerd Fonts Installer!"
display_fonts

# Prompt user for font choices
read -p "Please enter the numbers of the fonts you want to install (separate with spaces): " -a font_choices

# Validate input and collect selected fonts
selected_fonts=()
for choice in "${font_choices[@]}"; do
    if [[ "$choice" -ge 1 && "$choice" -le ${#fonts[@]} ]]; then
        selected_fonts+=("${fonts[$((choice - 1))]}")
    else
        echo "Invalid choice: $choice. Please run the script again."
        exit 1
    fi
done

# Install selected fonts
install_fonts "${selected_fonts[@]}"

clear
