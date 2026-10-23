# $ZDOTDIR/shell_customizations.d/40-nav.zsh - directory navigation hacks

## 1) zoxide integration
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
  alias cd='z'                           # enable zoxide fuzzy matching for cd
fi

# Always provide a predictable escape from the zoxide cd alias.
alias c='builtin cd'

## 2) Simple "type a directory name" → cd
setopt AUTO_CD                            # treat bare directory names as cd targets

## 3) Directory‐stack enhancements
setopt AUTO_PUSHD                         # pushd instead of cd, maintaining stack
setopt PUSHD_SILENT                       # don't print the stack on pushd/popd
setopt PUSHD_IGNORE_DUPS                  # drop duplicate entries in the stack
setopt PUSHD_TO_HOME                      # bare pushd sends you to $HOME
setopt PUSHDMINUS                         # allow `pushd -N` to pop N entries

## 4) Suppress redundant path echoes
autoload -Uz is-at-least && if is-at-least 5.8; then
  setopt CD_SILENT                        # don't print the new directory after cd
fi

## 5) Additional stack utilities
b() {                                      # b [N] → back N entries (default: 1)
  (( $# <= 1 )) || { print -ru2 -- 'usage: b [index]'; return 2; }
  dgo "${1:-1}"
}

alias d='dirs -v'                         # list stack with indices

dgo() {                                    # dgo N → jump to index N (0=current)
  emulate -L zsh
  setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
  (( $# == 1 )) && [[ $1 == <-> ]] || { print -ru2 -- 'usage: dgo <nonnegative index>'; return 2; }
  local -i n=$((10#$1))
  local -a stack=("$PWD" "${dirstack[@]}")
  (( n >= 0 && n < ${#stack} )) || { print -ru2 -- "Bad index: $1"; return 1; }
  builtin cd -- "${stack[$((n+1))]}"
}

# The standalone OMZ macOS plugin assumes an unloaded open_command helper.
if [[ $OSTYPE == darwin* ]]; then
  ofd() {
    if (( $# )); then
      command open "$@"
    else
      command open "$PWD"
    fi
  }
fi

# Optional keybindings (commented; tune per terminal)
# dir-back() { b 1; zle reset-prompt }
# dir-fwd()  { dgo 1; zle reset-prompt }
# zle -N dir-back; zle -N dir-fwd
# bindkey '^[^[OD' dir-back   # Alt-Left
# bindkey '^[^[OC' dir-fwd    # Alt-Right

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
