# ============================================================================
#  Zsh setup using $ZDOTDIR/shell_customizations.d/ (ordered, modular)
# ============================================================================

# zmodload zsh/zprof

# ---------------------------------------------------------------------------
#  .zshrc  (skeletal — Zim pre-init, then load customizations from directory)
# ---------------------------------------------------------------------------

# Powerlevel10k instant prompt (must be top-of-file)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------- Zim bootstrap --------------------
ZIM_HOME=${ZDOTDIR:-$HOME}/.zim
if [[ ! -e $ZIM_HOME/zimfw.zsh ]]; then
  if (( $+commands[curl] )); then
    curl -fsSL --create-dirs -o $ZIM_HOME/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p $ZIM_HOME && wget -nv -O $ZIM_HOME/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
if [[ ! $ZIM_HOME/init.zsh -nt ${ZDOTDIR:-$HOME}/.zimrc ]]; then
  source $ZIM_HOME/zimfw.zsh init -q
fi

# ---------------------------------------------------------------------
# Zim configuration   — cheatsheet: https://zimfw.sh/docs/cheatsheet/
# ---------------------------------------------------------------------

# Use degit instead of git as the default tool to install and update modules.
# zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration (MUST be set before init)
# --------------------

# git
# Set a custom prefix for the generated aliases. The default prefix is 'G'.
# zstyle ':zim:git' aliases-prefix 'g'

# input
# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

# termtitle
# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
# When remote (SSH), make it obvious in the title.
if [[ -n $SSH_CONNECTION ]]; then
  zstyle ':zim:termtitle' format '␥ %n@%m: %~'
else
  zstyle ':zim:termtitle' format '%n@%m: %~'
fi

# zim-z data location
ZSHZ_DATA=${ZDOTDIR:-$HOME}/.zshz-data

# zsh-autosuggestions
# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# zsh-syntax-highlighting
# Set what highlighters will be used.
# Docs: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor root)

# Customize the main highlighter styles.
# Docs: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# Initialize modules (must come AFTER the zstyles above)
source $ZIM_HOME/init.zsh

# -------------------- Load customizations (ordered) ------------------
# Files are sourced in lexicographic order. Set DEBUG_ZDOT=1 to echo loads.
if [[ -d $ZDOTDIR/shell_customizations.d ]]; then
  for f in $ZDOTDIR/shell_customizations.d/(*.zsh)(NOn); do
    (( ${+DEBUG_ZDOT} )) && echo "sourcing $f" >&2
    source "$f"
  done
fi

# Host-specific overrides (not under VC)
[[ -f $HOME/.env_local ]] && source $HOME/.env_local

# zprof

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
