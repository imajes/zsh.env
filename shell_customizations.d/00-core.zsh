# $ZDOTDIR/shell_customizations.d/00-core.zsh - baseline everywhere

# Set up a central cache dir for any plugins that use $ZSH_CACHE_DIR
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

## 1) Enhanced Globbing
setopt EXTENDED_GLOB           # Enable advanced glob patterns: ^, ~, #, etc.

## 2) Interactive Convenience
setopt INTERACTIVE_COMMENTS    # Allow `#`-style comments in interactive shell sessions

## 3) Safety Against Accidental Overwrites
setopt NO_CLOBBER              # Disallow `>` from clobbering files (use `>|` to override)

## 4) Robust Job Control
setopt NO_HUP                  # Don't send SIGHUP to jobs when the shell exits

# Input & UI
KEYTIMEOUT=1
bindkey -e
[[ -o interactive ]] && setopt CORRECT

# WORDCHARS tweak (stop at / on Ctrl-w)
WORDCHARS=${WORDCHARS//[\/]}

# PATH (deduplicated)
typeset -U path PATH
path=(
  $HOME/.local/bin
  $HOME/bin
  $path
)

# Generic aliases with feature detection
if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first --icons -g -h'
elif (( $+commands[exa] )); then
  alias ls='exa --group-directories-first --icons -g -h'
else
  alias ls='ls -G'
fi
alias la='ls -l -a'

# ripgrep convenience
alias rg='rg -p -M 200 --max-columns-preview --sort=path'

# bat as cat/less when available (interactive only)
if [[ -o interactive ]] && (( $+commands[bat] )); then
  alias cat='bat'
  alias less='bat'
fi

# quick root shell helper (from originals)
alias ss='sudo su -'

if (( $+commands[ggrep] )); then
  alias grep='ggrep --color=auto'
fi

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
