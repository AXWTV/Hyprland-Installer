#!/bin/bash

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Create a log file
LOG="install-$(date +%d-%H%M%S)_vgpt.log"

# Installing tgpt
curl -sSL https://raw.githubusercontent.com/aandrew-me/tgpt/main/install | bash -s /usr/local/bin || echo -e "${ERROR} Failed to install Tgpt"


# Create a directory for languages
mkdir -p ~/.local/share/vtt/english/ || echo -e "${ERROR} Failed to create directory for languages"

# Get the latest version of piper from the GitHub releases page
version=$(curl -s "https://api.github.com/repos/rhasspy/piper/releases/latest" | grep -o '"tag_name": "[^"]*' | grep -o '[^"]*$')

# Determine the architecture of the current system
arch=$(uname -m)

# Set the URL for the piper binary based on the detected architecture and latest version
url="https://github.com/rhasspy/piper/releases/download/${version}/piper_linux_${arch}.tar.gz"

# Download the piper binary using the generated URL
wget -q $url -O piper.tar.gz || echo -e "${ERROR} Failed to download piper binary"

# Extract the downloaded tarball to the current directory
tar -xzf piper.tar.gz || echo -e "${ERROR} Failed to extract piper binary"

# Remove the downloaded tarball
rm piper.tar.gz || echo -e "${ERROR} Failed to remove piper binary"

cd piper || echo -e "${ERROR} Failed to change directory to piper"

# Download the ONNX models for English
wget -q https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/libritts_r/medium/en_US-libritts_r-medium.onnx?download=true -P ~/.local/share/vtt/english/ -O en_US-libritts_r-medium.onnx || echo -e "${ERROR} Failed to download en_US-libritts_r-medium.onnx"
wget -q https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/libritts_r/medium/en_US-libritts_r-medium.onnx.json?download=true -P ~/.local/share/vtt/english/ -O en_US-libritts_r-medium.onnx.json || echo -e "${ERROR} Failed to download en_US-libritts_r-medium.onnx.json"

# Create symbolic links for piper and vosk-transcriber
sudo ln -sf $(pwd)/piper /usr/local/bin || echo -e "${ERROR} Failed to create symbolic link for piper"
sudo ln -sf $(pwd)/piper ~/.local/bin/piper || echo -e "${ERROR} Failed to create symbolic link for piper in ~/.local/bin"

# Install vosk
pip3 -v install vosk || echo -e "${ERROR} Failed to install vosk"

# Create symbolic link for vosk-transcriber
sudo ln -sf ~/.local/bin/vosk-transcriber /usr/local/bin || echo -e "${ERROR} Failed to create symbolic link for vosk-transcriber"

# Download the Vosk models for English and Indian English
wget -q https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip || echo -e "${ERROR} Failed to download vosk-model-
