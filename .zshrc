# Disable fancy config in pure TTY (TERM=linux)
if [[ "$TERM" == "linux" ]]; then
    source $HOME/.config/zsh/tty.zsh
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
export TERMCMD='kitty'

# Input method support (Wayland/X11)
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=default
export XMODIFIERS=@im=default
export INPUT_METHOD=default
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# ─── PATH ────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# ─── History Settings ────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_ALL_DUPS      # no duplicates
setopt HIST_IGNORE_SPACE         # no space
setopt SHARE_HISTORY             # share across sessions
setopt INC_APPEND_HISTORY        # write immediately
setopt HIST_REDUCE_BLANKS

# ─── Aliases ─────────────────────────────────────────────────────────────────
alias ls='ls --color=auto' 
alias grep='grep --color=auto'
alias neovim='nvim'
alias rm='rm -i'
alias minifetch='fastfetch -c $HOME/.config/fastfetch/mini.jsonc'
alias eza='eza --icons=always'
alias :q='exit'
alias cat='bat'
alias clock='tty-clock -csS'

# ─── Bindings ───────────────────────────────────────────────────────────────
# When in menu-select mode (visual menu):
zmodload zsh/complist
bindkey -M menuselect '^N' down-line-or-history     # Ctrl+N: down
bindkey -M menuselect '^P' up-line-or-history       # Ctrl+P: up  
bindkey -M menuselect '^F' accept-and-hold          # Ctrl+F: accept but keep menu
bindkey -M menuselect '^[[Z' reverse-menu-complete  # Shift+Tab: up

# Vi mode
bindkey -v
export KEYTIMEOUT=5
bindkey -M vicmd -r ':'
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^V' edit-command-line

# eval
eval "$(zoxide init zsh)"

# ─── Functions ───────────────────────────────────────────────────────────────
source $HOME/.config/zsh/func.zsh

# ─── Optional Plugins (if installed) ─────────────────────────────────────────
source $HOME/.config/zsh/autosuggestions.zsh
source $HOME/.config/zsh/p10k.zsh

# ─── Completion Settings (with menu-select) ──────────────────────────────────
autoload -Uz compinit menu-select
setopt globstarshort

source $HOME/.config/zsh/fzftab.zsh

autoload -Uz compinit 
compinit

source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
