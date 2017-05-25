# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"

alias gs="git s"
alias gsl="git status"
alias glog="git l"

# Plugins:
plugins=(git gitfast osx gem npm)

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

source $HOME/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
