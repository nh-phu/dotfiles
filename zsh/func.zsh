# ─── Functions ───────────────────────────────────────────────────────────────
fdcd() {
  local dir
  dir=$(find . -type d 2>/dev/null | fzf) && cd "$dir"
}
alias cdz='fdcd'

pj() {
  cd ~/Projects/"$(ls ~/Projects | fzf)" 2>/dev/null || return
  # nvim .
}

cf() {
  cd ~/.config/"$(ls ~/.config | fzf)" 2>/dev/null || return
  nvim .
}

y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [[ -n $cwd && "$cwd" != "$PWD" ]] && cd "$cwd"
  rm -f -- "$tmp"
}

spf() {
    os=$(uname -s)

    # Linux
    if [[ "$os" == "Linux" ]]; then
        export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
    fi

    command spf "$@"

    [ ! -f "$SPF_LAST_DIR" ] || {
        . "$SPF_LAST_DIR"
        rm -f -- "$SPF_LAST_DIR" > /dev/null
    }
}

# ─── Better History Search with fzf ─────────────────────────────────────────
# Enhanced history search function
fzf-history-widget() {
  BUFFER=$(fc -ln 1 | fzf --tac --no-sort --exact --height 50% --query "$LBUFFER" \
    --preview 'echo {}' --preview-window=down:3:wrap)
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget           # Ctrl+R: fzf history search
