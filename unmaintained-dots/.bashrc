parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

alias ls="ls"
alias ll="ls -aSf"
alias l="ls -l"
alias status="git status";
alias add="git add";
alias commit="git commit";
alias push="git push";
alias clone="git clone"

TERMINAL=alacritty

# COLORS
GREEN="\001\e[1;32m\002"
WHITE="\001\e[1;97m\002"
YELLOW="\001\e[1;33m\002"
RED="\001\e[1;31m\002"
MAGNETA="\001\e[1;35m\002"
VIOLET="\001\e[1;34m\002"
BLUE="\001\e[1;36m\002"
DEFAULT="\001\e[0m\002"

show_git_branch() {
  if [ ! -z "$(parse_git_branch)" ]; then
    echo -e "$MAGNETA git:($RED$(parse_git_branch)$MAGNETA)$DEFAULT"
  else
    echo -e ""
  fi
}


# PROMPTS
# PS1="$GREEN\\u$WHITE@$GREEN\\h:$YELLOW\\W$WHITE\\$ $DEFAULT" ## unnat@jaro:directory$ 
PS1="$GREEN➥  $BLUE\W\$(show_git_branch) $DEFAULT" # ➥ directory git:(branch) 

# Environment Path variable
export PATH="$PATH:$HOME/.config/rofi/bin"
