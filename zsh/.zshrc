# Created by newuser for 5.8

alias ls="ls"
alias ll="ls -aSf"
alias l="ls -l"
alias status="git status";
alias add="git add";
alias commit="git commit";
alias push="git push";
alias clone="git clone"

TERM=alacritty

bindkey '^H' backward-kill-word
bindkey ';5~' forward-kill-word
bindkey ';5D' backward-word
bindkey ';5C' forward-word

# PROMPTS
function precmd {
  parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
  }
  show_git_branch() {
    if [ ! -z "$(parse_git_branch)" ]; then
      echo -e "%F{magent}git:(%F{red}$(parse_git_branch)%F{magenta}) "
    else
      echo -e ""
    fi
  }
  PROMPT="%F{green}➥  %F{cyan}%B%c $(show_git_branch)%b%f" 
  RPROMPT="$()"
}
# Environment Path variable
export PATH="$PATH:$HOME/.config/rofi/bin"
export PATH="$PATH:/opt/android-studio/bin"
export _JAVA_AWT_WM_NONREPARENTING=1
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
