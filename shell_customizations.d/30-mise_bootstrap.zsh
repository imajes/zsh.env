# mise in "env" mode (no shims). Fast, cached, prompt-first.

(( ${+commands[mise]} )) || return 0
typeset -gU path fpath

# 0) Ensure shims are NOT on PATH (env mode replaces them with real paths)
: ${MISE_SHIM_DIR:=${XDG_DATA_HOME:-$HOME/.local/share}/mise/shims}
path=(${path:#$MISE_SHIM_DIR})

# 1) Resolve commands & caches
local -r _MISE_CMD=${commands[mise]}
local -r _MISE_CACHE=${XDG_CACHE_HOME:-$HOME/.cache}/mise
local -r _MISE_ENV_CACHE="$_MISE_CACHE/env"
mkdir -p -- "$_MISE_ENV_CACHE" "$_MISE_CACHE/functions"

# Choose the fastest env printer available
local -a _MISE_ENV_CMD
if "$_MISE_CMD" env -s zsh >/dev/null 2>&1; then
  _MISE_ENV_CMD=($_MISE_CMD env -s zsh)
else
  _MISE_ENV_CMD=($_MISE_CMD hook-env -s zsh)  # fallback for older builds
fi

# 2) Project config finder (stop at $HOME by default)
: ${MISE_STOP_AT:=$HOME}
typeset -gA _MISE_CFG_CACHE
_mise_find_cfg() {
  emulate -L zsh
  local d=${PWD:A} f
  while :; do
    [[ $d == $MISE_STOP_AT ]] && return 1
    for f in .mise.toml mise.toml .tool-versions; do
      [[ -e $d/$f ]] && { print -r -- "$d/$f"; return 0; }
    done
    [[ $d == / ]] && return 1
    d=${d:h}
  done
}
_mise_find_cfg_cached() {
  emulate -L zsh
  local key=${PWD:A}
  [[ -n ${_MISE_CFG_CACHE[$key]-} ]] && {
    [[ ${_MISE_CFG_CACHE[$key]} == NONE ]] && return 1
    print -r -- "${_MISE_CFG_CACHE[$key]}"; return 0
  }
  local p; if p=$(_mise_find_cfg); then
    _MISE_CFG_CACHE[$key]=$p; print -r -- "$p"
  else
    _MISE_CFG_CACHE[$key]=NONE; return 1
  fi
}

# 3) Apply env lazily, cached by (mise version + cfg content hash)
_mise_env_apply_for_pwd() {
  emulate -L zsh
  local cfg; cfg=$(_mise_find_cfg_cached) || return 0
  [[ -n $cfg && -e $cfg ]] || return 0

  zmodload -F zsh/stat b:zstat 2>/dev/null || return 0
  local ver hash
  ver="$("$_MISE_CMD" --version 2>/dev/null | head -n1)"
  hash=$(command shasum -a 256 -- "$cfg" 2>/dev/null | awk '{print $1}')
  local key="${${cfg:A}//\//__}.v${ver}.${hash}"
  local file="$_MISE_ENV_CACHE/$key.zsh"

  if [[ ! -r $file ]]; then
    local tmp="$_MISE_ENV_CACHE/.${key}.$$"
    if "${_MISE_ENV_CMD[@]}" >| "$tmp" 2>/dev/null; then
      mv -f -- "$tmp" "$file"
    else
      rm -f -- "$tmp" 2>/dev/null || true
      return 0
    fi
  fi
  source -- "$file"
}

# 4) Completions refresh (optional, deferred)
_mise_refresh_completions_bg() {
  emulate -L zsh
  local compdir= d
  for d in $fpath; do [[ -w $d ]] && { compdir=$d; break; } done
  [[ -z $compdir ]] && { compdir="$_MISE_CACHE/functions"; fpath=($compdir $fpath); }
  mkdir -p -- "$compdir"
  local compfile="$compdir/_mise"
  if [[ ! -e $compfile || $compfile -ot $_MISE_CMD ]]; then
    "$_MISE_CMD" complete --shell zsh >| "$compfile.tmp" 2>/dev/null \
      && mv -f -- "$compfile.tmp" "$compfile"
  fi
}

# 5) Defer work: env now (after prompt) + completions in the background
if autoload -Uz zsh-defer 2>/dev/null && command -v zsh-defer >/dev/null; then
  zsh-defer _mise_env_apply_for_pwd
  zsh-defer _mise_refresh_completions_bg
else
  autoload -Uz add-zsh-hook 2>/dev/null || true
  _mise_precmd_once() { _mise_env_apply_for_pwd; add-zsh-hook -d precmd _mise_precmd_once; }
  add-zsh-hook precmd _mise_precmd_once
  { _mise_refresh_completions_bg } &!
fi
