
# ============================================================================
#  Multi-file Z-dot setup — place each block in $ZDOTDIR with the given name
# ============================================================================

# ---------------------------------------------------------------------------
#  .zshrc  (skeletal — only boot + loader logic)
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
# Module configuration
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
  zstyle ':zim:termtitle' format 'SSH %n@%m: %~'
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

# -------------------- Env loaders ----------------------
for f in $ZDOTDIR/.env_{core,history,theme,auth,dev,nav}; do
  [[ -f $f ]] && source $f
done

# Portable / remote tweaks (SSH or container)
if [[ -n $SSH_CONNECTION || -f /.dockerenv ]]; then
  [[ -f $ZDOTDIR/.env_portable ]] && source $ZDOTDIR/.env_portable
fi

# Host-specific overrides (not under VC)
[[ -f $HOME/.env_local ]] && source $HOME/.env_local

# Optional drop-in directory for small customizations
# Files are sourced in lexicographic order. Uncomment to enable.
# for f in $ZDOTDIR/shell_customizations.d/*.zsh(.N); do
#   source "$f"
# done

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
# ---------------------------------------------------------------------------
#  END .zshrc
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
#  .env_core  — baseline everywhere
# ---------------------------------------------------------------------------

# Editor preference & interactive wrappers (nvim → vim → vi)
# Choose the best available editor and set EDITOR/VISUAL.
# In interactive shells, calling 'vi' or 'vim' will redirect to the chosen editor
# and pause with a helpful message so you can opt out.
__editor_choice=""
if (( $+commands[nvim] )); then
  __editor_choice="nvim"
elif (( $+commands[vim] )); then
  __editor_choice="vim"
elif (( $+commands[vi] )); then
  __editor_choice="vi"
fi
export EDITOR=${__editor_choice:-vi}
export VISUAL=$EDITOR

# Interactive wrappers only; scripts won't be blocked
if [[ -o interactive ]]; then
  __editor_should_pause() {
    # Pause by default; allow opt-out with EDITOR_WRAPPER_NOPAUSE=1
    [[ -n $EDITOR_WRAPPER_NOPAUSE ]] && return 1
    return 0
  }
  vi() {
    local target=$EDITOR
    if [[ $target != vi ]] && __editor_should_pause; then
      printf "Running %s instead of vi. Press Enter to continue, or run 'command vi' to force system vi.
" "$target"
      printf "Tip: to disable these wrappers this session: 'unfunction vi vim'
"
      read -r
    fi
    command "$target" "$@"
  }
  vim() {
    local target=$EDITOR
    if [[ $target != vim ]] && __editor_should_pause; then
      printf "Running %s instead of vim. Press Enter to continue, or run 'command vim' to force system vim.
" "$target"
      printf "Tip: to disable these wrappers this session: 'unfunction vi vim'
"
      read -r
    fi
    command "$target" "$@"
  }
fi

# History & keymap

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

# quick root shell helper (from originals)
alias ss='sudo su -'

if (( $+commands[ggrep] )); then
  alias grep='ggrep --color=auto'
fi

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
# ---------------------------------------------------------------------------
#  END .env_core
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
#  .env_history  — history backend & behaviour
# ---------------------------------------------------------------------------

# Primary zsh history file and sizes
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=200000
export SAVEHIST=200000

# Behaviour
setopt APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY HIST_VERIFY HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY HIST_REDUCE_BLANKS HIST_EXPIRE_DUPS_FIRST

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
    for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
    for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
    for key ('k') bindkey -M vicmd ${key} history-substring-search-up
    for key ('j') bindkey -M vicmd ${key} history-substring-search-down
    unset key
  fi
fi

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
# ---------------------------------------------------------------------------
#  END .env_history
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
#  .env_theme  — dark/light detection & colour exports
# ---------------------------------------------------------------------------

# Use caller-provided macos_is_dark() if present; otherwise fallback to LIGHT.
update_theme() {
  dark_override=false

  dark=0
  if $dark_override; then
    dark=1
  elif typeset -f macos_is_dark >/dev/null && macos_is_dark; then
    dark=1
  fi

  if (( dark )); then
    export LIGHT_MODE='DARK'
    export BAT_THEME='Visual Studio Dark+'
    export GREP_COLORS='sl=49;38;5;247;2:cx=49;38;5;242;2:mt=48;5;197;38;5;222;1;4:fn=49;38;5;199;2:ln=49;38;5;199;2:bn=49;38;5;141;2:se=49;38;5;81;1'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=228'
  else
    export LIGHT_MODE='LIGHT'
    export BAT_THEME='Coldark-Cold'
    export GREP_COLORS='sl=49;38;5;242;2:cx=49;38;5;247;2:mt=48;5;222;38;5;197;1;4:fn=49;38;5;199;2:ln=49;38;5;199;2:bn=49;38;5;141;2:se=49;38;5;81;1'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=090'
  fi
}

# macOS: run on every prompt; elsewhere rely on LIGHT_MODE or your own hook
[[ $(uname) == Darwin ]] && precmd() { update_theme }
: "${LIGHT_MODE:=LIGHT}"

# Load Powerlevel10k prompt (after theme vars)
[[ -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] && source ${ZDOTDIR:-$HOME}/.p10k.zsh

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
# ---------------------------------------------------------------------------
#  END .env_theme
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
#  .env_auth  — 1Password helpers & secret fetch (safe to version-control)
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------

# Load 1Password shell plugins if present
[[ -f $HOME/.op/plugins.sh ]] && source $HOME/.op/plugins.sh

# Fetch secrets only if logged in
if (( $+commands[op] )) && op account list --session >/dev/null 2>&1; then
  export FONT_AWESOME_AUTH_TOKEN=$(op read op://infra/fontawesome/token 2>/dev/null)
  export ANTHROPIC_API_KEY=$(op read op://AI/Anthropic/key 2>/dev/null)
  export GROQ_API_KEY=$(op read op://AI/Groq/key 2>/dev/null)
fi

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
# ---------------------------------------------------------------------------
#  END .env_auth
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
#  .env_dev  — language & tooling helpers (optional)
# ---------------------------------------------------------------------------

# Yarn / Node paths
path=(
  $HOME/.yarn/bin
  $HOME/.config/yarn/global/node_modules/.bin
  $path
)
export MISE_NODE_COREPACK=true

# Ruby performance & alias
export RUBY_YJIT_ENABLE=1 ENABLE_YJIT=1 DISABLE_SPRING=true
alias spacecop='rubocop -A --only Style/FrozenStringLiteralComment,Layout/EmptyLines,Style/StringLiterals,Layout/EmptyLinesAroundBlockBody,Layout/EmptyLineAfterMagicComment,Layout/EmptyLinesAroundClassBody,Layout/TrailingWhitespace,Layout/EmptyLinesAroundBlockBody,Layout/EmptyLinesAroundModuleBody,Layout/EmptyLinesAroundMethodBody,Layout/SpaceAroundOperators,Layout/TrailingEmptyLines,Layout/SpaceInsideHashLiteralBraces,Layout/EmptyLineAfterGuardClause,Layout/FirstHashElementIndentation,Layout/EmptyLines,Layout/SpaceAfterComma,Layout/HashAlignment'

# ripgrep convenience
alias rg='rg -p -M 200 --max-columns-preview --sort=path'

# Neovim Ruby + Pry history logs (from originals)
export NVIM_RUBY_LOG_FILE=$HOME/.local/state/nvim/nvim_ruby.log
export NVIM_RUBY_LOG_LEVEL=debug
export PRY_HISTFILE=.pry_history

# bat as cat/less when available (interactive only)
if [[ -o interactive ]] && (( $+commands[bat] )); then
  alias cat='bat'
  alias less='bat'
fi

# macOS-only Java path helpers
# plus fork-safety workaround used by some GUI toolchains
if [[ $(uname) == Darwin ]]; then
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi

# macOS-only Java path helpers
if [[ $(uname) == Darwin ]] && [[ -x /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  path=( /opt/homebrew/opt/openjdk/bin $path )
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
fi

# acme.sh path if present
if [[ -d $HOME/.acme.sh ]]; then
  path=( $HOME/.acme.sh $path )
fi

# Angular CLI completion (optional)
if (( $+commands[ng] )); then
  source <(ng completion script)
fi

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
# ---------------------------------------------------------------------------
#  END .env_dev
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
#  .env_portable  — remote/CI/container lightweight mode
# ---------------------------------------------------------------------------

export POWERLEVEL9K_DISABLE_GITSTATUS=true
export ZSH_AUTOSUGGEST_DISABLED=1
export ZSH_HIGHLIGHT_STYLE=none
: ${LIGHT_MODE:=LIGHT}

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
# ---------------------------------------------------------------------------
#  END .env_portable
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
#  .env_local  — template (not version-controlled)
# ---------------------------------------------------------------------------

# Neovide
export NEOVIDE_FORK=true
alias neovide='/Applications/Neovide.app/Contents/MacOS/neovide'

# Homebrew nightly WezTerm updater
alias upwez='brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest'

# Google Cloud SDK paths & completion
if [[ -f $HOME/src/google-cloud-sdk/path.zsh.inc ]]; then
  source $HOME/src/google-cloud-sdk/path.zsh.inc
fi
if [[ -f $HOME/src/google-cloud-sdk/completion.zsh.inc ]]; then
  source $HOME/src/google-cloud-sdk/completion.zsh.inc
fi

# GAM & Codex helpers
alias gam="$HOME/bin/gam/gam"
export RUST_LOG_LEVEL=debug
alias codex="RUST_LOG=codex_core=$RUST_LOG_LEVEL,codex_tui=$RUST_LOG_LEVEL /Users/james/src/artificial_intelligence/codex/codex-rs/target/aarch64-apple-darwin/release/codex"
#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
# ---------------------------------------------------------------------------
#  END .env_local
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
#  .env_nav  — directory stack navigation helpers
# ---------------------------------------------------------------------------

# Use zsh's native directory stack (AUTO_PUSHD et al.)
setopt AUTO_PUSHD PUSHD_SILENT PUSHD_IGNORE_DUPS PUSHDMINUS

# 'b [N]' -> go back N directories (default 1)
b() {
  local n=${1:-1}
  cd ~-"$n" 2>/dev/null || { print -u2 "No such stack entry: $n"; return 1; }
}

# 'd' -> show stack numbered (0=current)
alias d='dirs -v'

# 'dgo N' -> jump to absolute index from `d`
dgo() {
  local n=${1:?usage: dgo <index-from-d>}
  local -a stack; stack=(${(f)"$(dirs -p)"})
  (( n >= 0 && n < ${#stack} )) || { print -u2 "Bad index: $n"; return 1; }
  cd -- "${stack[$((n+1))]}"
}

# Optional keybindings (commented; tune per terminal)
# dir-back() { b 1; zle reset-prompt }
# dir-fwd()  { dgo 1; zle reset-prompt }
# zle -N dir-back; zle -N dir-fwd
# bindkey '^[^[OD' dir-back   # Alt-Left
# bindkey '^[^[OC' dir-fwd    # Alt-Right

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
# ---------------------------------------------------------------------------
#  END .env_nav
# ---------------------------------------------------------------------------
