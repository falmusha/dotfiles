# zplug
# ------------------------------------------------------------------------------
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Pure prompt
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug mafredri/zsh-async, from:github

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# source plugins and add commands to $PATH
zplug load

# History file configuration
# ------------------------------------------------------------------------------
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Command aliases
# ------------------------------------------------------------------------------
alias g="git"
alias gl="git l"
alias gs="git s"
alias mr="cd ~/iCloud/School/Research/repo"


# ENV Vars
# ------------------------------------------------------------------------------
export PATH=$HOME/.bin:$PATH:$HOME/.cargo/bin:$HOME/.rvm/bin
export EDITOR="nvim"

export RACK_ENV="development"
export ERL_AFLAGS="-kernel shell_history enabled"

# FZF
# ------------------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND=$(cat <<EOF
  rg --files --hidden --follow --glob "!.git/*"
EOF
)
export FZF_DEFAULT_OPTS=$(cat <<EOF
  --bind up:preview-up,down:preview-down
EOF
)

zsh_perf() {
  for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done
}

# Machine specific zsh profile
# ------------------------------------------------------------------------------
source $HOME/.zshrc.local
