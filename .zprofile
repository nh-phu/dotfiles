#!/usr/bin/env zsh

# ─── Environment ─────────────────────────────────────────────────────────────
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export VISUAL=$EDITOR
export MANPAGER="nvim +Man!"
export TERMCMD='alacritty'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_DIRS="/etc/xdg"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export OLLAMA_MODELS=$XDG_DATA_HOME/ollama/models
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export W3M_DIR="$XDG_STATE_HOME/w3m"
