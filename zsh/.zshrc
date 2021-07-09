# Created by newuser for 5.8

alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias vim='nvim'
alias vi='nvim'
alias history='history -E'
# Git aliases
alias status='git status'
alias add='git add'
alias commit='git commit'
alias push='git push'
alias clone='git clone'
alias init='git init'
# Screen recording with ffmpeg
alias recordscreen='cd ~/Videos/ScreenRecording; ffmpeg -f x11grab -i :0.0 "$(date '+%d-%b_%I:%M_%p').mp4"'
# Ping 4 times
alias ping='ping -c 4'

# History
HISTSIZE=5000
HISTFILE=~/.cache/zsh/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# No character at the end of a line
PROMPT_EOL_MARK=''

TERMINAL=alacritty

# Easy command editing keybindings
bindkey '^H' backward-kill-word
bindkey '^[[3~' delete-char
bindkey ';5D' backward-word
bindkey ';5C' forward-word

# Go to end of line
bindkey '^E' end-of-line

# CD ../../ to ....
cd() {
    builtin cd "${1//../../}"
}

# PROMPTS
function precmd {
  parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
  }
  show_git_branch() {
    if [ ! -z "$(parse_git_branch)" ]; then
      echo -e "%F{magenta} $(parse_git_branch) "
    else
      echo -e ""
    fi
  }
  #PROMPT="%F{blue}  %F{green} %F{cyan}  %B%c $(show_git_branch)%b%f"
  PROMPT="%F{green} %F{cyan}  %B%c $(show_git_branch)%b%f"
  #RPROMPT="%F{red}%(?..%? )%F{green}↵"
}

# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Environment Path variable
export PATH="$PATH:$HOME/.config/rofi/bin"
export PATH="$PATH:/opt/android-studio/bin"
export _JAVA_AWT_WM_NONREPARENTING=1
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


# ZSH Syntax Highlighting
#source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship
#eval "$(starship init zsh)"
