# Command aliases
# ------------------------------------------------------------------------------
alias l="ls -la"
alias gl="git l"
alias gs="git s"
alias mr="cd ~/iCloud/School/Research/repo"
alias t="tmux"
alias tl="tmux ls"

# CLI: Improved
# ------------------------------------------------------------------------------
alias cat="bat"
alias ping="prettyping --nolegend"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

# ENV Vars
# ------------------------------------------------------------------------------
if test -e $HOME/.cargo/bin
  set -x PATH $HOME/.cargo/bin $PATH
end

if test -e $HOME/.bin
  set -x PATH $HOME/.bin $PATH
end

set -x EDITOR nvim
set -x RACK_ENV development
set -x ERL_AFLAGS "-kernel shell_history enabled"

# remove greeting message
set fish_greeting ""

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

# Python
# ------------------------------------------------------------------------------
if command --search python3 >/dev/null do
  if test -e (python3 -m site --user-base)/bin
    set -x PATH $PATH (python3 -m site --user-base)/bin
  end
end

if command --search python2 >/dev/null do
  if test -e (python2 -m site --user-base)/bin
    set -x PATH $PATH (python2 -m site --user-base)/bin
  end
end

# Machine specific fish profile
# ------------------------------------------------------------------------------
source $HOME/.fish.local
