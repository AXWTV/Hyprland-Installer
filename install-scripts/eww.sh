#!/bin/bash
# https://github.com/AXWTV

eww_pkg (
rust
hyprshot
cargo
gtk3-devel
rust-gdk-devel
pango-devel
gdk-pixbuf2-devel
libdbusmenu-devel
libdbusmenu-gtk3-devel
cairo-devel
cairo-gobject-devel
glib2-devel
gcc-c++
glibc-devel
gtk-layer-shell
gtk-layer-shell-devel
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"


# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_hypr-pkgs.log"
MLOG="install-$(date +%d-%H%M%S)_nwg-look2.log"


# Installation of main components
printf "\n%s - Installing eww packages.... \n" "${NOTE}"

for EWW in "${eww_pkg[@]}"; do
  install_package "$EWW" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $EWW install had failed, please check the install.log"
    exit 1
  fi
done

# Check if nwg-look directory exists
if [ -d "eww" ]; then
  printf "${INFO} eww directory already exists. Updating...\n"
  cd eww || exit 1
  git stash
  git pull
else
  # Clone nwg-look repository if directory doesn't exist
  if git clone https://github.com/elkowar/eww.git; then
    cd eww || exit 1
  else
    echo -e "${ERROR} Download failed for eww." 2>&1 | tee -a "$LOG"
    mv "$MLOG" ../Install-Logs/ || true
    exit 1
  fi
fi

# Build EWW
cargo build --release --no-default-features --features=wayland 2>&1 | tee -a "$MLOG"
cd target/release
chmod +x ./eww
sudo cp -r eww /usr/bin/

cd "$PARENT_DIR" || exit 1
printf "${OK} eww installed successfully.\n" 2>&1 | tee -a "$MLOG"

clear
