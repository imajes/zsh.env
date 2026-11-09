# /etc/zprofile has already run macOS path_helper in login shells. Establish
# the base order here in both login and non-login shells, before mise activates.
() {
  emulate -L zsh
  local entry go_root
  local -a base candidates
  typeset -gU path
  # Discover user tools before plugins as well as before mise. All platforms
  # use the same order, without relying on a Homebrew entry as an insertion anchor.
  export GOPATH=${GOPATH:-$HOME/src/go}
  candidates=("$HOME/bin" "$HOME/.codex/bin" "$HOME/.local/bin"
              "$HOME/.atuin/bin" "$HOME/.yarn/bin"
              "${XDG_CONFIG_HOME:-$HOME/.config}/yarn/global/node_modules/.bin"
              "$HOME/.cargo/bin" "$HOME/.acme.sh")
  for go_root in "${(@s/:/)GOPATH}"; do
    [[ -n $go_root ]] && candidates+=("$go_root/bin")
  done
  [[ $OSTYPE == darwin* ]] && candidates+=(/opt/homebrew/bin /opt/homebrew/sbin)
  for entry in "${candidates[@]}"; do
    # PATH cannot encode a colon inside an entry. Check aliases of HOME too.
    [[ $entry == /* && $entry != *:* && -d $entry && ${entry:A} != ${HOME:A} ]] && base+=("$entry")
  done
  for entry in "${path[@]}"; do
    # Empty/relative entries search the current directory; bare HOME is unsafe.
    [[ $entry == /* && ${entry:A} != ${HOME:A} ]] && base+=("$entry")
  done
  path=("${base[@]}")
}
