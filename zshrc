# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ifahad7"


# Aliases: 
# --------
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias l="ls -la"
alias drpx="cd ~/Dropbox"
alias uw="ssh falmusha@ecelinux.uwaterloo.ca"
alias py="python3.2"

# Git
alias gs="git status"
alias glg="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"


# Plugins:
# --------
plugins=(git vundle osx gem coffee brew npm)


# Settings:
#-----------

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"


unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

source $ZSH/oh-my-zsh.sh

#export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
#export PATH=$PATH:/usr/local/mysql/bin

# RVM
# ---
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
#export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
