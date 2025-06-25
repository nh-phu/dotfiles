# Disable fancy config in pure TTY (TERM=linux)
if [[ "$TERM" == "linux" ]]; then
  export EDITOR=nvim
  export VISUAL=nvim
  export MANPAGER="nvim +Man!"
  PROMPT='[%n@%m %~]%# '
  return
fi

# ─── Powerlevel10k Instant Prompt (keep at top) ──────────────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─── Environment ─────────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=$EDITOR
export MANPAGER="nvim +Man!"

# Input method support (Wayland/X11)
export GTK_IM_MODULE=default
export QT_IM_MODULE=default
export XMODIFIERS=@im=default
export INPUT_METHOD=default
# Simplified LS_COLORS to avoid parsing issues
export LS_COLORS="di=01;34:ln=01;36:ex=01;32:*.tar=01;31:*.gz=01;31:*.zip=01;31:*.jpg=01;35:*.png=01;35:*.mp3=00;36"
# ─── PATH ────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# ─── History Settings ────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_ALL_DUPS      # no duplicates
setopt SHARE_HISTORY             # share across sessions
setopt INC_APPEND_HISTORY        # write immediately
setopt HIST_REDUCE_BLANKS

# ─── Aliases ─────────────────────────────────────────────────────────────────
alias ls='ls --color=auto' 
alias grep='grep --color=auto'
alias vim='nvim'
alias neovim='nvim'
alias rm='rm -i'
alias sl='sl | lolcat'

# ─── Functions ───────────────────────────────────────────────────────────────
fdcd() {
  local dir
  dir=$(find . -type d 2>/dev/null | fzf) && cd "$dir"
}
alias cdz='fdcd'

pj() {
  cd ~/Projects/"$(ls ~/Projects | fzf)" 2>/dev/null || return
  nvim .
}

config() {
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

# ─── Optional Plugins (if installed) ─────────────────────────────────────────
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ─── Powerlevel10k Theme ─────────────────────────────────────────────────────
[[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]] && \
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':fzf-tab:complete:*:*' fzf-preview \
  '[[ -d $realpath ]] && ls --color=always $realpath || bat --style=numbers --color=always --line-range=1:50 $realpath 2>/dev/null || head -n 50 $realpath'

zstyle ':fzf-tab:*' fzf-flags --preview-window=right:50%:wrap
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:complete:*:options' fzf-preview  # No preview for options
zstyle ':fzf-tab:*' continuous-trigger '/'        # Continue completion with /

# ─── Completion Settings (with menu-select) ──────────────────────────────────
autoload -Uz compinit menu-select
setopt globstarshort

zstyle ':completion:*' file-patterns '.*' '*'
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*' list-colors ''

compinit

#Keybind
bindkey '^F' autosuggest-accept
bindkey '^[f' forward-word
bindkey '^E' autosuggest-clear

# Menu navigation
bindkey '^N' menu-complete                # Ctrl+N: next completion
bindkey '^P' reverse-menu-complete        # Ctrl+P: previous completion
bindkey '^[[Z' reverse-menu-complete      # Shift+Tab: previous completion

# When in menu-select mode (visual menu):
zmodload zsh/complist
bindkey -M menuselect '^N' down-line-or-history     # Ctrl+N: down
bindkey -M menuselect '^P' up-line-or-history       # Ctrl+P: up  
bindkey -M menuselect '^F' accept-and-hold          # Ctrl+F: accept but keep menu
bindkey -M menuselect '^[[Z' reverse-menu-complete  # Shift+Tab: up

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

# Vi mode
bindkey -v
