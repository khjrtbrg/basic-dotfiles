# make j work
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# aliases
alias ll='ls -la'
alias k='clear'

# set up prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
setopt PROMPT_SUBST
PROMPT='%F{yellow}%*%f %F{magenta}[%f%F{cyan}%1~%f%F{green}$(parse_git_branch)%f%F{magenta}]%f $ '