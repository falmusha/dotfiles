function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
      echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function get_pwd() {
    print -D $PWD
}

PROMPT='%{$fg_bold[red]%}%m$(git_prompt_info): %{$fg_bold[yellow]%}$(get_pwd) $reset_color%}
$ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[orange]%} ["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[orange]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}git:$(current_branch)+"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[orange]%}git:$(current_branch)"
