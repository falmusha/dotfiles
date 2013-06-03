function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
      echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function get_pwd() {
    print -D $PWD
}

PROMPT='
%{$fg[red]%}%n %{$fg[white]%}@ %{$fg[blue]%}%m$(git_prompt_info)%{$fg[white]%}: %{$fg[yellow]%}$(get_pwd) $reset_color%}
%{$fg[green]%}$ $reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[grey]%} ["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[grey]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}git:+"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}git:"
