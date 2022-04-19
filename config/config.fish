# Command aliases
# ------------------------------------------------------------------------------
alias l="ls -la"
alias gl="git l"
alias gs="git s"
alias t="tmux"
alias tl="tmux ls"

# CLI: Improved
# ------------------------------------------------------------------------------
alias ping="prettyping --nolegend"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"


# $PATH
# ------------------------------------------------------------------------------
set -x PATH $PATH /opt/local/bin/

if test -e $HOME/.cargo/bin
    set -x PATH $HOME/.cargo/bin $PATH
end

if test -e $HOME/.bin
    set -x PATH $HOME/.bin $PATH
end

if test (arch) = i386
    set HOMEBREW_PREFIX /usr/local
else
    set HOMEBREW_PREFIX /opt/homebrew
end

if test -e $HOMEBREW_PREFIX
    eval ($HOMEBREW_PREFIX/bin/brew shellenv)
end

if type -q fnm
    eval (fnm env)
end

if type -q rbenv
    status --is-interactive; and rbenv init - fish | source
end

if type -q rvm; and test -e $HOME/.rvm/bin
    set -x PATH $HOME/.rvm/bin $PATH
end

if test -e /Users/(whoami)/Library/Android/sdk
    set ANDROID_HOME /Users/(whoami)/Library/Android/sdk
    set -x PATH $PATH $ANDROID_HOME/tools
    set -x PATH $PATH $ANDROID_HOME/tools/bin
    set -x PATH $PATH $ANDROID_HOME/platform-tools
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
