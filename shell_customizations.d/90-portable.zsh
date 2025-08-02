# $ZDOTDIR/shell_customizations.d/90-portable.zsh - remote/CI/container mode

# Slim prompt & plugins for SSH/CI/containers
if [[ -n $SSH_CONNECTION || -f /.dockerenv ]]; then
  echo "Disabling gitstatus, autosuggest and highlight style for portalbe environments."

  export POWERLEVEL9K_DISABLE_GITSTATUS=true
  export ZSH_AUTOSUGGEST_DISABLED=1
  export ZSH_HIGHLIGHT_STYLE=none
  : ${LIGHT_MODE:=LIGHT}
fi
#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
