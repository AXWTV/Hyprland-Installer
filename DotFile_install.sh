#!/bin/bash

printf "\e[1;37m 
 █▀▄ █▀█ ▀█▀ █▀▀ ▀█▀ █   █▀▀ 
 █▄▀ █▄█  █  █▀  ▄█▄ █▄▄ ██▄ 
┌────────────────────────────────────────────────────┐
│ [1]  Run ./install.sh                              │
│ [2]  PowerLevel10K | zsh-syntax-highlighting       │
│ [3]  copy .zshrc                                   │
│ [4]  App-Installation                              │
│ [0]  Exit                                          │
└────────────────────────────────────────────────────┘
\e[0m"
read -rp ' ❯ Enter option: ' OPTION

case "$OPTION" in

1)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  chmod +x install.sh
  source install.sh
  "$SCRIPT_DIR/DotFile_install.sh"
  ;;

2)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  echo "###############################################"
  echo "#  PowerLevel10K and zsh-syntax-highlighting  #"
  echo "###############################################"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  cp -r assets/.p10k.zsh ~/.p10k.zsh
  echo "###################"
  echo "#    Complete     #"
  echo "###################"
  "$SCRIPT_DIR/DotFile_install.sh"
  ;;

3)
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  cp -r assets/.zshrc ~/.zshrc

  "$SCRIPT_DIR/DotFile_install.sh"
  ;;

4)
  source App-Installation.sh
  ;;

0)
  echo "Exiting"
  ;;

*)
  echo "Invalid command !"
  ;;
esac
