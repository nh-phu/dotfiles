zstyle ':fzf-tab:complete:*:*' fzf-preview \
  '[[ -d $realpath ]] && ls --color=always $realpath || bat --style=numbers --color=always --line-range=1:50 $realpath 2>/dev/null || head -n 50 $realpath'

zstyle ':fzf-tab:*' fzf-flags --preview-window=right:40%:nowrap
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:complete:*:options' fzf-preview  # No preview for options
zstyle ':fzf-tab:*' continuous-trigger '/'        # Continue completion with /

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' file-patterns '.*' '*'
zstyle ':completion:*' menu no
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

