source ~/.bash/colors
source ~/.bash/aliases

export EDITOR='mvim -v'
export VISUAL='mvim -v'

export BASH_ENV='~/.bash/env'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=verbose
PS1="${COLOR_MAGENTA}[${COLOR_CYAN}\W${COLOR_GREEN}\$(__git_ps1 ' %s')${COLOR_MAGENTA}]${COLOR_NONE}\$ "
function name_tab() {
  echo -ne "\033]0;$1\007"
}

[[ -f `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
