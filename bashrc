source ~/.bash/colors
source ~/.bash/aliases
source ~/.bash/git-completion.bash

export EDITOR='vim'
export VISUAL='vim'

export BASH_ENV='~/.bash/env'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

[[ -f `brew --prefix`/etc/bash_completion ]] && . `brew --prefix`/etc/bash_completion
[[ -f `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

function git_branch {
  ref=$(git symbolic-ref HEAD 2>/dev/null) || return
  echo ${ref#refs/heads/}
}

function git_status() {
  # + changes are staged and ready to commit
  # * unstaged changes are present
  # ? untracked files are present
  # ^ local commits need to be pushed to the remote
  local status="$(git status --porcelain 2>/dev/null)"
  local output=''

  [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
  [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output*"
  [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"

  echo "$output" # needs to be quoted to not evaluate the symbols
}

function git_prompt() {
  local branch=$(git_branch)
  local status=$(git_status)
  local output=''

  [[ -n $branch ]] && output="$output $branch"
  [[ -n $status ]] && output="$output $status"

  echo "$output" # needs the quotes to preserve whitespace
}

PS1="${COLOR_YELLOW}\D{%T} ${COLOR_MAGENTA}[${COLOR_CYAN}\W${COLOR_GREEN}\$(git_prompt)${COLOR_MAGENTA}]${COLOR_NONE}\$ "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
