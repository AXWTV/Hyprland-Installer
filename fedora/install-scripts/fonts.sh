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


# Directories for font installation
FONT_DIR="$HOME/.local/share/fonts"

# Create the fonts directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Function to download and install fonts using curl
install_font() {
    FONT_URL=$1
    FONT_NAME=$2
    FONT_ARCHIVE=$3

    echo "Downloading $FONT_NAME..."
    curl -L "$FONT_URL" -o "$FONT_ARCHIVE"
    
    echo "Extracting $FONT_NAME..."
    mkdir -p "$FONT_DIR/$FONT_NAME"
    unzip -q "$FONT_ARCHIVE" -d "$FONT_DIR/$FONT_NAME"
    rm "$FONT_ARCHIVE"
    echo "$FONT_NAME installed successfully!"
}

# Install Hack font
install_font "https://github.com/chrissimpkins/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip" "Hack" "Hack-v3.003-ttf.zip"

# Install Iosevka font
install_font "https://github.com/oble/isevka/releases/download/v3.0.0/ttf-iosevka-3.0.0.zip" "Iosevka" "ttf-iosevka-3.0.0.zip"

# Install Nerd Fonts Symbols Only
install_font "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/NerdFontsSymbolsOnly.zip" "NerdFontsSymbolsOnly" "NerdFontsSymbolsOnly.zip"

# Install JetBrainsMono font
install_font "https://github.com/JetBrains/JetBrainsMono/releases/download/v2.0/JetBrainsMono-2.0.zip" "JetBrainsMono" "JetBrainsMono-2.0.zip"

# Install Font Awesome (Free)
install_font "https://github.com/FortAwesome/Font-Awesome/releases/download/5.15.4/fontawesome-free-5.15.4-desktop.zip" "FontAwesome" "fontawesome-free-5.15.4-desktop.zip"

# Update font cache
echo "Updating font cache..."
fc-cache -fv

echo "Fonts installation complete!"\

clear
