[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Autosuggestion settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'                    # Gray color
ZSH_AUTOSUGGEST_STRATEGY=(history completion)             # Better suggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20                        # Prevent long suggestions

# Autosuggestion keybinds
bindkey '^F' autosuggest-accept           # Ctrl+F: accept full suggestion
bindkey '^[f' forward-word                # Alt+F: accept one word
bindkey '^E' autosuggest-clear            # Ctrl+E: clear suggestion
#bindkey '^N' menu-complete 
#bindkey '^P' reverse-menu-complete 
#bindkey '^N' history-beginning-search-forward  # Ctrl+N: next history entry
#bindkey '^P' history-beginning-search-backward # Ctrl+P: previous history entry:
bindkey '^N' history-search-forward # Ctrl+N: next history entry
bindkey '^P' history-search-backward # Ctrl+P: previous history entry:

