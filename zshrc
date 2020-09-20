# make j work
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# aliases
alias ll='ls -la'
alias k='clear'

# set up prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
parse_git_status() {
  # + changes are staged and ready to commit
  # * unstaged changes are present
  # ? untracked files are present
  # ^ local commits need to be pushed to the remote
  local git_status=$(git status --porcelain 2> /dev/null)
  local output=''

  [[ -n $(egrep '^[MADRC]' <<<"$git_status") ]] && output="$output+"
  [[ -n $(egrep '^.[MD]' <<<"$git_status") ]] && output="$output*"
  [[ -n $(egrep '^\?\?' <<<"$git_status") ]] && output="$output?"

  echo $output
}
git_prompt() {
  local git_branch=$(parse_git_branch)
  local git_status=$(parse_git_status)
  local output=''

  [[ -n $git_branch ]] && output="$output $git_branch"
  [[ -n $git_status ]] && output="$output $git_status"

  echo $output
}
setopt PROMPT_SUBST
PROMPT='%F{yellow}%*%f %F{magenta}[%f%F{cyan}%1~%f%F{green}$(git_prompt)%f%F{magenta}]%f $ '
