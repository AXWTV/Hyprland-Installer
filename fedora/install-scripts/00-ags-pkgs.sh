#!/bin/bash

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_ags-pkgs.log"

# Bun
if [ -d ~/.bun/ ]; then
    echo "Bun is already installed. Skipping..."
else
   curl -fsSL https://bun.sh/install | bash 2>&1 | tee -a "$LOG"
fi

# Sass
if [ -d /usr/local/lib/node_modules/sass ]; then
    echo "Sass is already installed. Skipping..."
else
    sudo npm install -g sass 2>&1 | tee -a "$LOG"
fi

# Rustup/Cargo
if command -v rustup &> /dev/null; then
    echo "Rustup and Cargo in already installed. Skipping..."
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
fi

# Matugen
cargo install matugen

# Power profile daemon setup
sudo systemctl enable power-profiles-daemon
sudo systemctl start power-profiles-daemon
