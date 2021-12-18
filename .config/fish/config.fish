
set termEmu (basename "/"(ps -f -p (cat /proc/(echo %self)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //'))
set TTY (tty)

if status is-interactive
    and test "$termEmu" != "--type=ptyHost"
    and test "$termEmu" != "fish;#toggleterm#1"
    and test "$TTY" != "/dev/tty1"
    neofetch --config ~/.config/neofetch/sconfig.conf
end

set fish_greeting

# Key binding mode
function fish_user_key_bindings
    fish_default_key_bindings
end

bind \cj beginning-of-line
bind \ck end-of-line


###############
### ALIASES ###
###############

# GoTop
alias htop='gotop'

# Pacman 
alias pac='sudo pacman'

# vim
alias vim='lvim'
alias v='lvim'

# wpm
alias wpm='wpm --stats-file .cache/wpm/wpm.csv'

# Colorize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ls
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -A'
alias ll='ls -alF'
alias lf='vifm'

# git
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
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

# Quit
alias :q='exit'

##################
### Keybindings ##
##################

bind \c\backspace 'backward-kill-bigword'

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

################
### ENV VARS ###
################

export TERMINAL=alacritty
export QT_QPA_PLATFORMTHEME=qt5ct
# export QT_STYLE_OVERRIDE=Breeze

export XAUTHORITY=/home/unnat/.config/X11/Xauthority

# XMonad dirs
# export XMONAD_CONFIG_DIR=~/.config/xmonad/
# export XMONAD_DATA_DIR=~/.config/xmonad/
# export XMONAD_CACHE_DIR=~/.cache/xmonad/

# PATH var
export PATH="$PATH:/home/unnat/.local/bin:/home/unnat/.config/lemonbar/bin/"

# BSPWM's lemonbar
export PANEL_FIFO=/tmp/panel-fifo
export PANEL_WM_NAME=bspwm_panel

# Fixes IntelliJ's idea blank window
export _JAVA_AWT_WM_NONREPARENTING=1

#############
### Xinit ###
#############

if test "$TTY" = "/dev/tty1"
    pgrep -x bspwm || startx $HOME/.config/X11/xinitrc
end

#####################
### CUSTOM PROMPT ###
#####################

#function fish_prompt
    #printf '%s %s  %s%s%s ' (set_color green) (set_color blue) (prompt_pwd) (fish_git_prompt) (set_color normal)
#end

