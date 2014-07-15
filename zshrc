# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ifahad7"


# Aliases: 
# --------
alias l="ls -la"
alias drpx="cd ~/Dropbox"
alias uw="ssh falmusha@ecelinux.uwaterloo.ca"

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

# RVM
# ---
if type rvm &> /dev/null ; then
  echo "NO RVM"
else
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
fi

# Preferred editor
# ----------------
export EDITOR='vim'

# PYTHON
# ------
PYTHONPATH=$PYTHONPATH:/usr/local/Cellar/opencv/2.4.9/lib/python2.7/site-packages
