# ~/.bashrc
# [[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach
export EDITOR=nvim
export VISUAL=$EDITOR

# input method
export GTK_IM_MODULE=default
export QT_IM_MODULE=default
export XMODIFIERS=@im=default
export INPUT_METHOD=default

# Exit early if not running interactively
[[ $- != *i* ]] && return

# === PATH ===
# export PATH="$HOME/.cargo/bin:$PATH"

# === BASH COMPLETION ===
# [[ -f /usr/share/bash-completion/bash_completion ]] && \
#   source /usr/share/bash-completion/bash_completion

# === ble.sh (Bash Line Editor) ===
#[[ -s ~/.local/share/blesh/ble.sh ]] && source ~/.local/share/blesh/ble.sh

# === ble.sh Appearance Tweaks ===

# Completion menu (Tab-completion popup)
# ble-face -s auto_complete             fg=240,underline=false
# ble-face -s menu_complete_match       bold
# ble-face -s menu_complete_selected    reverse
# ble-face -s menu_desc_default         none
# ble-face -s menu_desc_type            ref:syntax_delimiter
# ble-face -s menu_desc_quote           ref:syntax_quoted
# ble-face -s menu_filter_fixed         bold
# ble-face -s menu_filter_input         fg=16,bg=229
# ble-face -s command_directory         underline=false
# ble-face -s filename_directory         underline=false
#
# # Minimal .blerc
# bleopt highlight_timeout_sync=150
# bleopt highlight_timeout_async=2000
# bleopt complete_auto_delay=150
#
# === FZF ===
# [[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# === PROMPT ===
#PS1='[\u@\h \W]\$ '

# === ALIASES ===
alias ls='ls --color=auto'
alias grep='grep --color=auto'
HISTSIZE=10000                    # Commands to remember in memory
HISTFILESIZE=20000               # Commands to save in history file
HISTCONTROL=ignoreboth:erasedups # Ignore duplicates and commands starting with space
shopt -s histappend              # Append to history instead of overwriting
alias rm='rm -i'

# === FZF COMMAND HISTORY ===
bind '"\er": "$(history | fzf | cut -c 8-)\n"'

# === FZF CD HELPER ===
fdcd() {
  local dir
  dir=$(find . -type d 2>/dev/null | fzf) && cd "$dir"
}
alias cdz='fdcd'

# === PROJECT LAUNCHER ===
pj() {
  cd ~/Projects/"$(ls ~/Projects | fzf)" 2>/dev/null || return
  nvim .
}

# config file
config() {
    cd ~/.config/"$(ls ~/.config | fzf)" 2>/dev/null || return
    nvim .
}
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


# [[ ! ${BLE_VERSION-} ]] || ble-attach
#
# source /home/puchan/.config/broot/launcher/bash/br
