#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# base devel #

base=( 
  base-devel
)
## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
source "${SCRIPT_DIR}/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_base.log"


# Installation of main components
printf "\n%s - Installing base-devel \n" "${NOTE}"

for PKG1 in "${base[@]}"; do
  install_package_pacman "$PKG1" | tee -a "$LOG"
done

clear