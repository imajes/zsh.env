# /etc/zprofile has already run macOS path_helper in login shells. Establish
# the base order here in both login and non-login shells, before mise activates.
() {
  emulate -L zsh
  local entry
  local -a base
  typeset -gU path
  for entry in "$HOME/bin" "$HOME/.codex/bin" "$HOME/.local/bin" \
               /opt/homebrew/bin /opt/homebrew/sbin; do
    [[ -d $entry ]] && base+=("$entry")
  done
  for entry in "${path[@]}"; do
    # Empty/relative entries search the current directory; bare HOME is unsafe.
    [[ $entry == /* && ${entry:A} != ${HOME:A} ]] && base+=("$entry")
  done
  path=("${base[@]}")
}
