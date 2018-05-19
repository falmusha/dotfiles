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

# command aliases
alias g="git"
alias gl="git l"
alias gs="git s"
alias mr="cd ~/iCloud/School/Research/repo"

# ENV Vars
export EDITOR='nvim'
export ERL_AFLAGS="-kernel shell_history enabled"
export PATH="$HOME/.rvm/bin:$PATH" # For RVM
export RACK_ENV="development"
export TERM=xterm-256color

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND=$(cat <<EOF
  rg --files --hidden --follow --glob "!.git/*"
EOF
)
export FZF_DEFAULT_OPTS=$(cat <<EOF
  --bind up:preview-up,down:preview-down
EOF
)

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Machine specific zsh profile
source $HOME/.zshrc.local

