# $ZDOTDIR/shell_customizations.d/05-history.zsh - history backend & behaviour

# Primary zsh history file and sizes
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=200000
export SAVEHIST=200000

# Behaviour

## 1) History Persistence
setopt APPEND_HISTORY             # Append new commands to the history file on shell exit
setopt INC_APPEND_HISTORY         # Write each command to the history file immediately
setopt SHARE_HISTORY              # Share history across all running shell sessions
setopt EXTENDED_HISTORY           # Record timestamp of each command in the history file

## 2) Entry Hygiene
setopt HIST_IGNORE_SPACE          # Skip commands that start with a space from being logged
setopt HIST_IGNORE_ALL_DUPS       # Remove all previous duplicates when adding a new entry
setopt HIST_REDUCE_BLANKS         # Squeeze multiple blanks into one in each history entry

## 3) Interactive Search
setopt HIST_FIND_NO_DUPS          # Don't show duplicate entries in incremental search
setopt HIST_VERIFY                # Require confirmation before executing history expansions

## 4) Maintenance Rules
setopt HIST_EXPIRE_DUPS_FIRST     # When trimming history, remove older duplicates before unique entries

# Atuin: magical history (keep near HISTFILE so it owns the stack)
# Docs: https://atuin.sh
if [[ -f $HOME/.atuin/bin/env ]]; then
  source $HOME/.atuin/bin/env
fi
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh)"
fi

# history-substring-search keybindings (guarded)
if zmodload -F zsh/terminfo +p:terminfo 2>/dev/null; then
  if (( $+functions[history-substring-search-up] && $+functions[history-substring-search-down] )); then
    for key ('^[[A' '^P' ${terminfo[kcuu1]}); do
      bindkey ${key} history-substring-search-up
    done
    for key ('^[[B' '^N' ${terminfo[kcud1]}); do
      bindkey ${key} history-substring-search-down
    done
    for key ('k'); do
      bindkey -M vicmd ${key} history-substring-search-up
    done
    for key ('j'); do
      bindkey -M vicmd ${key} history-substring-search-down
    done
    unset key
  fi
fi

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
