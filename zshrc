# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ifahad7"


# Aliases:
# --------
alias l="ls -la"
alias ll="ls -l"
alias uw="ssh falmusha@ecelinux.uwaterloo.ca"

# Git
alias gs="git status"
alias glg="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"


# Plugins:
# --------
plugins=(git gitfast osx gem brew npm)


# Settings:
#-----------

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"


unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

source $ZSH/oh-my-zsh.sh

# Preferred editor
# ----------------
export EDITOR='vim'

source $HOME/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
