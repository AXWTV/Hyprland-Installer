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

# Create Directory for Install Logs
if [ ! -d Install-Logs ]; then
    mkdir Install-Logs
fi

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"

# Define the directory where your scripts are located
script_directory=install-scripts

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

# Function to display the menu and get user choice
show_menu() {
    echo -e "\e[1;37m"
    echo "╭──────────────────────────────────────────────────────╮"
    echo "│ [1]  Install Hyprland Packages                       │"
    echo "│ [2]  Install GTK Themes                              │"
    echo "│ [3]  Configure Bluetooth                             │"
    echo "│ [4]  Install & Configure SDDM                        │"
    echo "│ [5]  Install XDG-DESKTOP-PORTAL-HYPRLAND             │"
    echo "│ [6]  Install zsh, oh-my-zsh & nushell                │"
    echo "│ [7]  Install on ASUS ROG Laptops                     │"
    echo "│ [8]  Clone repo and install pre-configured dotfiles  │"
    echo "│ [9]  Install PowerLevel10K                           │"
    echo "│ [0]  Exit                                            │"
    echo "╰──────────────────────────────────────────────────────╯"
    echo -e "\e[0m"
}

# Main loop
while true; do
    show_menu
    read -rp ' ❯ Enter option: ' OPTION

    case "$OPTION" in
        1)
            execute_script "copr.sh"
            execute_script "00-hypr-pkgs.sh"
            ;;
        2)
            execute_script "gtk_themes.sh"
            ;;
        3)
            execute_script "bluetooth.sh"
            ;;
        4)
            execute_script "sddm.sh"
            ;;
        5)
            execute_script "xdph.sh"
            ;;
        6)
            execute_script "shell.sh"
            ;;
        7)
            execute_script "rog.sh"
            ;;
        8)
            execute_script "dotfiles.sh"
            ;;
        9)
            execute_script "p10k.sh"
            ;;
        0)
            echo "Exiting"
            exit 0
            ;;
        *)
            echo "Invalid command!"
            ;;
    esac
    echo "Press any key to continue..."
    read -n 1
    clear
done
