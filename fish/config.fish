if status is-interactive
    #fm6000 -c=bright_blue -dog
end

set fish_greeting

#############
## COLORS ###
############

set fish_color_normal white
set fish_color_command blue
set fish_color_param brcyan
set fish_color_valid_path --underline
set fish_color_autosuggestion "#4b5263"
set fish_color_error "#929AB2"
set fish_color_comment "#4b5263"
set fish_color_search_match --background="#759DF3"
set __fish_git_prompt_color_branch brmagenta
set __fish_git_prompt_color_prefix cyan
set __fish_git_prompt_color_suffix cyan

# Key binding mode
function fish_user_key_bindings
    fish_default_key_bindings
    #fish_vi_key_bindings
end

bind \cj beginning-of-line
bind \ck end-of-line

###############
### PROMPT ###
##############
##### Custom Prompt #####

function fish_prompt
    printf '%s %s  %s%s%s ' (set_color green) (set_color blue) (prompt_pwd) (fish_git_prompt) (set_color normal)
end

###############
### ALIASES ##
##############


# Touch diary file
alias touchdia='cd Documents/.diary; touch (date "+%d-%b-%Y"); nvim (date "+%d-%b-%Y")'

# Find xmonad process and kill
alias killxmonad='kill (ps aux | grep xmonad | awk \'NR==1{print $2}\')'

# Pacman 
alias pac='sudo pacman'

# vim
alias vim='nvim'
alias v='nvim'

# wpm
alias wpm='python -m wpm --stats-file .cache/wpm/wpm.csv'

# Colorize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ls
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -A'
alias ll='ls -alF'

# git
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'
alias add='git add'
alias init='git init'
alias stat='git status'

# Screen recording with ffmpeg
alias recordscreen='cd ~/Videos/ScreenRecording; ffmpeg -f x11grab -i :0.0 "(date '+%d-%b_%I:%M_%p').mp4"'

# Ping 4 times
alias ping='ping -c 4'

##################
### Keybindings ##
##################

bind \c\backspace 'backward-kill-bigword'

################
### ENV VARS ###
################

export TERMINAL=alacritty
export QT_QPA_PLATFORMTHEME=qt5ct

# XMonad dirs
export XMONAD_CONFIG_DIR=~/.config/xmonad/
export XMONAD_DATA_DIR=~/.config/xmonad/
export XMONAD_CACHE_DIR=~/.cache/xmonad/

# PATH var
export PATH="$PATH:/home/unnat/.local/bin:/home/unnat/.config/lemonbar/bin/"

# BSPWM Lemonbar
export PANEL_FIFO=/tmp/panel-fifo
export PANEL_HEIGHT=22
export PANEL_FONT="Cascadia Mono"
export PANEL_WM_NAME=bspwm_panel

