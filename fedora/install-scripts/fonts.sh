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
LOG_FILE="$HOME/font_installation_log.txt"

# Create the fonts directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Create or clear the log file
> "$LOG_FILE"

# Function to download and install fonts using curl
install_font() {
    FONT_URL=$1
    FONT_NAME=$2
    FONT_ARCHIVE=$3

    echo "Downloading $FONT_NAME..."
    curl -L "$FONT_URL" -o "$FONT_ARCHIVE"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download $FONT_NAME from $FONT_URL" >> "$LOG_FILE"
        echo "$FONT_NAME failed to download."
        return 1
    fi
    
    echo "Extracting $FONT_NAME..."
    mkdir -p "$FONT_DIR/$FONT_NAME"
    unzip -q "$FONT_ARCHIVE" -d "$FONT_DIR/$FONT_NAME"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to extract $FONT_NAME from $FONT_ARCHIVE" >> "$LOG_FILE"
        echo "$FONT_NAME failed to extract."
        rm "$FONT_ARCHIVE"
        return 1
    fi
    
    rm "$FONT_ARCHIVE"
    echo "$FONT_NAME installed successfully!"
    return 0
}

# Install Hack font (latest release)
install_font "https://github.com/chrissimpkins/Hack/releases/latest/download/Hack.zip" "Hack" "Hack.zip"

# Install Iosevka font (latest release)
install_font "https://github.com/oble/isevka/releases/latest/download/ttf-iosevka.zip" "Iosevka" "ttf-iosevka.zip"

# Install Nerd Fonts Symbols Only (latest release)
install_font "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip" "NerdFontsSymbolsOnly" "NerdFontsSymbolsOnly.zip"

# Install JetBrainsMono font (latest release)
install_font "https://github.com/JetBrains/JetBrainsMono/releases/latest/download/JetBrainsMono.zip" "JetBrainsMono" "JetBrainsMono.zip"

# Install Font Awesome (Free) (latest release)
install_font "https://github.com/FortAwesome/Font-Awesome/releases/latest/download/fontawesome-free.zip" "FontAwesome" "fontawesome-free.zip"

# Update font cache
echo "Updating font cache..."
fc-cache -fv

# List out fonts that failed to install
echo "The following fonts failed to install:" >> "$LOG_FILE"
grep "failed" "$LOG_FILE" || echo "All fonts installed successfully." >> "$LOG_FILE"

# Display the log file content (optional)
cat "$LOG_FILE"
echo "Fonts installation complete!"

clear
