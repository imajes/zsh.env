# Select portable policy before Powerlevel10k and Zim load their modules.
typeset -gi ZSH_PORTABLE_MODE=0
if [[ -n $SSH_CONNECTION || -f /.dockerenv || ${CI:-false} == (true|1) ]]; then
  ZSH_PORTABLE_MODE=1
fi
