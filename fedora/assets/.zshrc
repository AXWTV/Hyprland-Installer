# https://github.com/AXWTV #
# # # # # # # # # # # # # #  
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
ENABLE_CORRECTION="true"

plugins=(
  dnf
  git 
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

###      -----User configuration------      ###
if [ ! -d "$HOME/git-projects" ]; then
  mkdir -p "$HOME/git-projects"
fi

alias vim=nvim
alias gt="cd $HOME/git-projects"
alias update="sudo dnf update"
alias ls="lsd -a"
alias lg="lazygit"

# source ~/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#eval "$(oh-my-posh init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

export PATH=$PATH:/home/axwtv/.spicetify

# bun completions
[ -s "/home/axwtv/.bun/_bun" ] && source "/home/axwtv/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


