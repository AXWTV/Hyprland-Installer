# https://github.com/AXWTV #
# # # # # # # # # # # # # #  
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
ENABLE_CORRECTION="true"

plugins=(
  dnf
  zsh-autosuggestions
  git 
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

###      -----User configuration------      ###
alias vim=nvim
alias gt="cd $HOME/git-projects"
alias update="sudo dnf update"
alias ls="lsd -al"

# source ~/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:/home/axwtv_bugassassin/.spicetify
