if status is-interactive
    neofetch
end

set fish_greeting

##############
### COLORS ###
#############

set fish_color_normal white
set fish_color_command blue
set fish_color_param brcyan
set fish_color_valid_path --underline
set fish_pager_color_description B3A06D yellow
set fish_color_autosuggestion "#5c6370"
set fish_color_error "#5c6370"
set fish_color_comment "#4b5263"
set fish_color_selection --background=FFCC66
set fish_color_search_match --background=FFCC66
set fish_color_history_current --bold
#set fish_color_redirection D4BFFF
#set fish_color_match F28779
#set fish_color_quote BAE67E
#set fish_color_end F29E74
#set fish_color_cancel -r
#set fish_pager_color_completion normal
#set fish_color_host normal
#set fish_color_user brgreen
#set fish_color_operator FFCC66
#set fish_color_escape 95E6CB
#set fish_color_cwd 73D0FF
#set fish_color_cwd_root red

# Key binding mode
function fish_user_key_bindings
    fish_default_key_bindings
    #fish_vi_key_bindings
end

###############
### PROMPT ###
##############

function fish_prompt
    printf '%s %s  %s%s ' (set_color green) (set_color brcyan) (prompt_pwd) (set_color normal)
end

###############
### ALIASES ##
##############

# vim and emacs
alias vim='nvim'
alias vi='nvim'

# Colorize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ls
alias ls='ls --color=auto -F'
alias l='ls'
alias la='ls -A'
alias ll='ls -alF'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

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

# i3 keyboard shortcuts cheatsheet
alias i3cheatsheet='grep -E "^bindsym" ~/.config/i3/config | grep -vE "^XF86" | less'

