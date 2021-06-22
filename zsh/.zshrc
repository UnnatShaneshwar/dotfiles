# Created by newuser for 5.8

alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias vim="nvim"
alias vi="nvim"
alias history="history -E"
# Git aliases
alias status="git status";
alias add="git add";
alias commit="git commit";
alias push="git push";
alias clone="git clone"
alias init="git init"
# Screen recording with ffmpeg
alias recordscreen='cd ~/Videos/ScreenRecording; ffmpeg -f x11grab -i :0.0 "$(date '+%d-%b_%I:%M_%p').mp4"'
# Show active ports
alias showports='sudo lsof -i -P -n'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
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
  PROMPT="%F{green}➥  %F{cyan}  %B%c $(show_git_branch)%b%f"
  #RPROMPT="%F{red}%(?..%? )%F{green}↵"
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

# ZSH Syntax Highlighting
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
