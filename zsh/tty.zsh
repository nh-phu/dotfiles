PROMPT='[%n@%m %~]%# '
bindkey -v
bindkey -M vicmd -r ':'
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"
# Additional useful bits for TTY
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Basic completion
autoload -U compinit
compinit

# Vi mode indicator in prompt (optional)
# PROMPT='[%n@%m %~]%(?.%#.%F{red}%#%f) '

# Essential aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'

# Better vi mode experience
bindkey '^R' history-incremental-search-backward
bindkey '^P' up-history
bindkey '^N' down-history
