# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"


# Aliases: 
# --------
alias zshconfig="mvim ~/.zshrc"
alias ohmyzsh="mvim ~/.oh-my-zsh"
alias l="ls -la"
alias drpx="cd ~/Dropbox"

# Git
alias gs="git status"
alias glg="git log"


# Plugins:
# --------
plugins=(git vundle osx gem coffee brew npm)


# Settings:
-----------

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"


source $ZSH/oh-my-zsh.sh
