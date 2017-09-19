# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"

# Plugins:
plugins=(git gitfast osx gem npm docker docker-compose)

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

unalias run-help
autoload run-help
source $ZSH/oh-my-zsh.sh

alias gs="git s"
alias gsl="git status"
alias glog="git l"

# ENV Vars
export PATH="$PATH:$HOME/.rvm/bin" # For RVM
export TERM=xterm-256color
export EDITOR='vim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Machine specific zsh profile
source $HOME/.zshrc.local

# Base16 Shell--configure term colors to be 256
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
