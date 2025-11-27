# $ZDOTDIR/shell_customizations.d/90-portable.zsh - remote/CI/container mode

# Slim prompt & plugins for SSH/CI/containers
if [[ -n $SSH_CONNECTION || -f /.dockerenv ]]; then
  echo "Disabling gitstatus, autosuggest and highlight style for portable environments."

  export POWERLEVEL9K_DISABLE_GITSTATUS=true
  export ZSH_AUTOSUGGEST_DISABLED=1
  export ZSH_HIGHLIGHT_STYLE=none
  : ${LIGHT_MODE:=LIGHT}

  # Enable OSC 7 reporting of the remote CWD back to the local terminal UI.
  # This lets supporting terminal panes track the remote working directory.
  autoload -Uz portable:osc7_cwd add-zsh-hook 2>/dev/null
  if (( ${+functions[add-zsh-hook]} )); then
    # Avoid duplicate hooks if this file is re-sourced.
    [[ ${precmd_functions[(r)portable:osc7_cwd]} ]] || add-zsh-hook precmd portable:osc7_cwd
    [[ ${chpwd_functions[(r)portable:osc7_cwd]} ]]  || add-zsh-hook chpwd  portable:osc7_cwd
  fi
fi
#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
