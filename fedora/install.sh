#!/bin/bash
# https://github.com/AXWTV
# https://github.com/JaKooLit
# Created by: JaKooLit
# Modified by: AXWTV

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting......."
    exit 1
fi

clear

printf "\n%.0s" {1..3}  
echo " █████╗ ██╗  ██╗██╗    ██╗████████╗██╗   ██╗"
echo "██╔══██╗╚██╗██╔╝██║    ██║╚══██╔══╝██║   ██║"
echo "███████║ ╚███╔╝ ██║ █╗ ██║   ██║   ██║   ██║"
echo "██╔══██║ ██╔██╗ ██║███╗██║   ██║   ╚██╗ ██╔╝"
echo "██║  ██║██╔╝ ██╗╚███╔███╔╝   ██║    ╚████╔╝ "
echo "╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝    ╚═╝     ╚═══╝  "
echo "Script By: JaKooLit     Modified by: AXWTV  "
printf "\n%.0s" {1..2} 

# Welcome message
echo "$(tput setaf 6)Welcome to AXWTV's Fedora-Hyprland Install Script!$(tput sgr0)"
echo
echo "$(tput setaf 166)ATTENTION: Run a full system update and Reboot first!! (Highly Recommended) $(tput sgr0)"
echo
echo "$(tput setaf 3)NOTE: You will be required to answer some questions during the installation! $(tput sgr0)"
echo
echo "$(tput setaf 3)NOTE: If you are installing on a VM, ensure to enable 3D acceleration else Hyprland wont start! $(tput sgr0)"
echo

read -p "$(tput setaf 6)Would you like to proceed? (y/n): $(tput sgr0)" proceed

if [ "$proceed" != "y" ]; then
    echo "Installation aborted."
    exit 1
fi

# Create Directory for Install Logs
if [ ! -d Install-Logs ]; then
    mkdir Install-Logs
fi

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Function to colorize prompts
colorize_prompt() {
    local color="$1"
    local message="$2"
    echo -n "${color}${message}$(tput sgr0)"
}

# Set the name of the log file to include the current date and time
LOG="install-$(date +%d-%H%M%S).log"

# Initialize variables to store user responses
bluetooth=""
dots=""
dotsb=""
gtk_themes=""
nvidia=""
nwg=""
rog=""
sddm=""
thunar=""
xdph=""
shell=""
p10k=""

# Define the directory where your scripts are located
script_directory=install-scripts

# Function to ask a yes/no question and set the response in a variable
ask_yes_no() {
    while true; do
        read -p "$(colorize_prompt "$CAT"  "$1 (y/n): ")" choice
        case "$choice" in
            [Yy]* ) eval "$2='Y'"; return 0;;
            [Nn]* ) eval "$2='N'"; return 1;;
            * ) echo "Please answer with y or n.";;
        esac
    done
}

# Function to ask a custom question with specific options and set the response in a variable
ask_custom_option() {
    local prompt="$1"
    local valid_options="$2"
    local response_var="$3"

    while true; do
        read -p "$(colorize_prompt "$CAT"  "$prompt ($valid_options): ")" choice
        if [[ " $valid_options " == *" $choice "* ]]; then
            eval "$response_var='$choice'"
            return 0
        else
            echo "Please choose one of the provided options: $valid_options"
        fi
    done
}
# Function to execute a script if it exists and make it executable
execute_script() {
    local script="$1"
    local script_path="$script_directory/$script"
    if [ -f "$script_path" ]; then
        chmod +x "$script_path"
        if [ -x "$script_path" ]; then
            "$script_path"
        else
            echo "Failed to make script '$script' executable."
        fi
    else
        echo "Script '$script' not found in '$script_directory'."
    fi
}

# Collect user responses to all questions
printf "\n"
ask_yes_no "-Do you have any nvidia gpu in your system?" nvidia
printf "\n"
ask_yes_no "-Install GTK themes? (required for Dark/Light function)" gtk_themes
printf "\n"
ask_yes_no "-Do you want to configure Bluetooth?" bluetooth
printf "\n"
ask_yes_no "-Install & configure SDDM log-in Manager plus (OPTIONAL) SDDM Theme?" sddm
printf "\n"
ask_yes_no "-Install XDG-DESKTOP-PORTAL-HYPRLAND? (for proper Screen Share ie OBS)" xdph
printf "\n"
ask_yes_no "-Install zsh, oh-my-zsh & nushell (test for nushell)?" shell
printf "\n"

# disabled in favor of fedora copr
#ask_yes_no "-Install nwg-look? (Theming app / lxappearance-like) WARNING Package takes abit long to install" nwg
#printf "\n"

ask_yes_no "-Installing on ASUS ROG Laptops?" rog
printf "\n"
ask_yes_no "-Do you want to clone the repo and install pre-configured beta Hyprland dotfiles? (for stable press n" dotsb
printf "\n"

# Skip dotfiles download prompt if the user chose the beta
if [ "$dotsb" == "Y" ]; then
    echo "Using beta Dotfiles..."
else
    printf "\n"
    ask_yes_no "-Do you want to download and install pre-configured Hyprland dotfiles?" dots
fi
#printf "\n"
#ask_yes_no "-Do you want to download and install pre-configured Hyprland dotfiles?" dots
#printf "\n"

ask_yes_no "-Do you want to PowerLevel10K?" p10k
printf "\n"


# Ensuring all in the scripts folder are made executable
chmod +x install-scripts/*

# Install hyprland packages
execute_script "copr.sh"
execute_script "00-hypr-pkgs.sh"
execute_script "fonts.sh"
execute_script "tmux.sh"

if [ "$nvidia" == "Y" ]; then
    execute_script "nvidia.sh"
fi

if [ "$nvidia" == "N" ]; then
    execute_script "hyprland.sh"
fi

if [ "$gtk_themes" == "Y" ]; then
    execute_script "gtk_themes.sh"
fi

if [ "$bluetooth" == "Y" ]; then
    execute_script "bluetooth.sh"
fi

if [ "$sddm" == "Y" ]; then
    execute_script "sddm.sh"
fi

if [ "$xdph" == "Y" ]; then
    execute_script "xdph.sh"
fi

if [ "$shell" == "Y" ]; then
    execute_script "shell.sh"
fi

if [ "$rog" == "Y" ]; then
    execute_script "rog.sh"
fi

if [ "$nwg" == "Y" ]; then
    execute_script "nwg-look.sh"
fi

if [ "$p10k" == "Y" ]; then
    execute_script "p10k.sh"
fi

execute_script "InputGroup.sh"

if [ "$dotsb" == "Y" ]; then
    execute_script "dotfiles-beta.sh"
fi

if [ "$dots" == "Y" ]; then
    execute_script "dotfiles.sh"

fi

execute_script "00-ags-pkgs.sh"

clear

printf "\n${OK} Yey! Installation Completed.\n"
printf "\n"
sleep 2
printf "\n${NOTE} You can start Hyprland by typing Hyprland (IF SDDM is not installed) (note the capital H!).\n"
printf "\n"
printf "\n${NOTE} It is highly recommended to reboot your system.\n\n"

read -rp "${CAT} Would you like to reboot now? (y/n): " HYP

if [[ "$HYP" =~ ^[Yy]$ ]]; then
    if [[ "$nvidia" == "Y" ]]; then
        echo "${NOTE} NVIDIA GPU detected. Rebooting the system..."
        systemctl reboot
    else
        systemctl reboot
    fi    
fi
