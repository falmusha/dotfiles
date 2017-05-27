# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"

# Plugins:
plugins=(git gitfast osx gem npm)

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
export TERM=xterm-16color
export EDITOR='vim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Machine specific zsh profile
source $HOME/.zshrc.local
