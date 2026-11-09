# Select portable policy before Powerlevel10k and Zim load their modules.
# The portable repository supplies account defaults here. Explicit 0/1 values
# take precedence; unset/auto uses session detection on other installations.
[[ -r $HOME/.zsh_portable-env ]] && source "$HOME/.zsh_portable-env"
case ${ZSH_PORTABLE_MODE:-auto} in
  0|1) typeset -gi ZSH_PORTABLE_MODE=$ZSH_PORTABLE_MODE ;;
  *)
    # Validate before integer assignment: environment strings are not arithmetic.
    typeset -gi ZSH_PORTABLE_MODE=0
    if [[ -n $SSH_CONNECTION || -f /.dockerenv || ${CI:-false} == (true|1) ]]; then
      ZSH_PORTABLE_MODE=1
    fi
    ;;
esac
