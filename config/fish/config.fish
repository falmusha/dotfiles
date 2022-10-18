# command aliases
# ------------------------------------------------------------------------------
alias l="ls -la"
alias gl="git l"
alias gs="git s"
alias t="tmux"
alias tl="tmux ls"

# CLI: Improved
# ------------------------------------------------------------------------------
alias python="python3"
alias ping="prettyping --nolegend"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

# Homebrew config
# ------------------------------------------------------------------------------
if test (arch) = i386
    set HOMEBREW_PREFIX /usr/local
else
    set HOMEBREW_PREFIX /opt/homebrew
end

if test -e $HOMEBREW_PREFIX
    eval ($HOMEBREW_PREFIX/bin/brew shellenv)
end

# $PATH
# ------------------------------------------------------------------------------
if test -e /Users/(whoami)/Library/Android/sdk
    set ANDROID_HOME /Users/(whoami)/Library/Android/sdk
    fish_add_path $ANDROID_HOME/tools $ANDROID_HOME/tools/bin \
        $ANDROID_HOME/platform-tools
end

if test -e $HOME/.cargo/bin
    fish_add_path $HOME/.cargo/bin
end

if type -q fnm
    eval (fnm env)
end

if type -q pyenv
    set PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin $PYENV_ROOT/shims
    pyenv init - | source
end

if type -q rvm; and test -e $HOME/.rvm/bin
    fish_add_path $HOME/.rvm/bin
end

if type -q rbenv
    status --is-interactive; and rbenv init - fish | source
end

if type -q pnpm
    set -x PNPM_HOME "$HOME/.pnpm"
    fish_add_path $PNPM_HOME
end

if test -e $HOME/.bin
    fish_add_path $HOME/.bin
end

# ENV Vars
# ------------------------------------------------------------------------------

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
    set_color white
    echo (prompt_pwd) (__fish_git_prompt)
    set_color white
    echo '> '
end

# helper functions
# ------------------------------------------------------------------------------
function shell_perf
    for i in (seq 1 10)
        /usr/bin/time $SHELL -i -c exit
    end
end

# Machine specific fish profile
# ------------------------------------------------------------------------------
if test -f $HOME/.fish.local
    source $HOME/.fish.local
end
