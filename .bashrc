#
# ~/.bashrc
#

# Exit early if not running interactively
[[ $- != *i* ]] && return

# === PATH ===
export PATH="$HOME/.local/bin:$PATH"

# === BASH COMPLETION ===
[[ -f /usr/share/bash-completion/bash_completion ]] && \
  source /usr/share/bash-completion/bash_completion

# === ble.sh (Bash Line Editor) ===
[[ -s ~/.local/share/blesh/ble.sh ]] && source ~/.local/share/blesh/ble.sh

# === ble.sh Appearance Tweaks ===

# Completion menu (Tab-completion popup)
ble-face -s auto_complete             fg=240,underline=false
ble-face -s menu_complete_match       bold
ble-face -s menu_complete_selected    reverse
ble-face -s menu_desc_default         none
ble-face -s menu_desc_type            ref:syntax_delimiter
ble-face -s menu_desc_quote           ref:syntax_quoted
ble-face -s menu_filter_fixed         bold
ble-face -s menu_filter_input         fg=16,bg=229
ble-face -s command_directory         underline=false
ble-face -s filename_directory         underline=false

# Minimal .blerc
bleopt highlight_timeout_sync=100
bleopt highlight_timeout_async=2000
# === FZF ===
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# === PROMPT ===
PS1='[\u@\h \W]\$ '

# === ALIASES ===
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias neovim='nvim'
alias spotify-player='spotify_player'
alias sl='sl | lolcat'

# === GIT SHORTCUTS ===
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

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

