# Command aliases
# ------------------------------------------------------------------------------
alias g="git"
alias gl="git l"
alias gs="git s"
alias mr="cd ~/iCloud/School/Research/repo"

# CLI: Improved
# ------------------------------------------------------------------------------
alias cat="bat"
alias ping="prettyping --nolegend"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

# ENV Vars
# ------------------------------------------------------------------------------
set -x PATH $HOME/.bin $HOME/.cargo/bin $HOME/.rvm/bin $PATH
set -x EDITOR nvim
set -x RACK_ENV development
set -x ERL_AFLAGS "-kernel shell_history enabled"

# FZF
# ------------------------------------------------------------------------------
set -x FZF_DEFAULT_COMMAND "rg --files --hidden --follow --glob \"!.git/*\""
set -x FZF_DEFAULT_OPTS "--bind up:preview-up,down:preview-down"

function fish_prompt
  echo -e ''
  set_color yellow
  echo (prompt_pwd) (__fish_git_prompt)
  set_color white
  echo '> '
end

function shell_perf
  for i in (seq 1 10)
    /usr/bin/time $SHELL -i -c exit
  end
end

# Machine specific zsh profile
# ------------------------------------------------------------------------------
source $HOME/.fish.local
