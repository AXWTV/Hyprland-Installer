#!/bin/bash
# 💫 https://github.com/AXWTV 💫 #
# Hyprland-DotFiles to clone from GitHub repository #

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

printf "${NOTE} Checking for existing Hyprland-DotFiles directory...\n"

# Check if Hyprland-DotFiles directory exists
if [ -d "AXWTV-Hyprland-DotFiles" ]; then
  printf "${NOTE} AXWTV-Hyprland-DotFiles directory found.\n"

  # Fetch the latest commit hash from the GitHub repository
  latest_commit_hash=$(curl -s https://api.github.com/repos/AXWTV/Hyprland-DotFiles/commits/main | grep '"sha"' | cut -d '"' -f 4)

  # Check the current commit hash in the local repository
  current_commit_hash=$(cd AXWTV-Hyprland-DotFiles && git rev-parse HEAD)

  # Check if the current commit hash matches the latest one
  if [ "$latest_commit_hash" = "$current_commit_hash" ]; then
    echo -e "${OK} AXWTV-Hyprland-DotFiles is up-to-date with the latest commit."
    
    # Sleep for 10 seconds before exiting
    printf "${NOTE} No update found. Sleeping for 10 seconds...\n"
    sleep 10
    exit 0
  else
    echo -e "${WARN} AXWTV-Hyprland-DotFiles is outdated (Local commit: $current_commit_hash, Latest commit: $latest_commit_hash)."
    read -p "Do you want to update to the latest version? (y/n): " update_choice
    if [ "$update_choice" = "y" ]; then
      echo -e "${NOTE} Proceeding to pull the latest changes." 2>&1 | tee -a "../Install-Logs/install-$(date +'%d-%H%M%S')_dotfiles.log"
      
      # Pull the latest changes from the repository
      cd AXWTV-Hyprland-DotFiles || exit 1
      git pull origin main || exit 1
      printf "${OK} Repository updated.\n"
    else
      echo -e "${NOTE} User chose not to update. Exiting..." 2>&1 | tee -a "../Install-Logs/install-$(date +'%d-%H%M%S')_dotfiles.log"
      exit 0
    fi
  fi
else
  echo -e "${NOTE} AXWTV-Hyprland-DotFiles directory not found. Cloning the repository...\n"

  # Clone the repository
  git clone https://github.com/AXWTV/Hyprland-DotFiles.git AXWTV-Hyprland-DotFiles || exit 1
  
  # Enter the cloned directory
  cd AXWTV-Hyprland-DotFiles || exit 1

  # Run copy.sh script
  chmod +x copy.sh
  ./copy.sh || exit 1

  echo -e "${OK} Repository cloned and dotfiles setup completed." 2>&1 | tee -a "../Install-Logs/install-$(date +'%d-%H%M%S')_dotfiles.log"
fi

clear
