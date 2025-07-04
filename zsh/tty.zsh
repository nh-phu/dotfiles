  [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'      # Dark gray for TTY
  bindkey '^F' autosuggest-accept           # Ctrl+F: accept full suggestion
  bindkey '^[f' forward-word                # Alt+F: accept one word
  bindkey '^E' autosuggest-clear            # Ctrl+E: clear suggestion
  bindkey '^N' history-search-forward # Ctrl+N: next history entry
  bindkey '^P' history-search-backward # Ctrl+P: previous history entry
  bindkey -v
  bindkey -M vicmd -r ':'
  export EDITOR=nvim
  export VISUAL=nvim
  export MANPAGER="nvim +Man!"
  PROMPT='[%n@%m %~]%# '
