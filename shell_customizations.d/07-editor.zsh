# $ZDOTDIR/shell_customizations.d/07-editor.zsh - baseline everywhere

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
      printf "Running %s instead of vi. Press Enter to continue, or run 'command vi' to force system vi.\n" "$target"
      printf "Tip: to disable these wrappers this session: 'unfunction vi vim'\n"
      read -r
    fi
    command "$target" "$@"
  }
  vim() {
    local target=$EDITOR
    if [[ $target != vim ]] && __editor_should_pause; then
      printf "Running %s instead of vim. Press Enter to continue, or run 'command vim' to force system vim.\n" "$target"
      printf "Tip: to disable these wrappers this session: 'unfunction vi vim'\n"
      read -r
    fi
    command "$target" "$@"
  }
fi

