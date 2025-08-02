# $ZDOTDIR/shell_customizations.d/40-nav.zsh - directory navigation hacks

## 1) zoxide integration
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
  alias c='/bin/cd'                       # use pure cd instead of zoxide
  alias cd='z'                           # enable zoxide fuzzy matching for cd
fi

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
  local n=${1:-1}
  cd ~-"$n" 2>/dev/null || { print -u2 "No such stack entry: $n"; return 1; }
}

alias d='dirs -v'                         # list stack with indices

dgo() {                                    # dgo N → jump to index N (0=current)
  local n=${1:?usage: dgo <index>}
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
