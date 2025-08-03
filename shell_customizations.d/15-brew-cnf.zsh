# $ZDOTDIR/shell_customizations.d/15-brew-cnf.zsh - Homebrew "command not found" integration

if (( $+commands[brew] )); then
  HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  [[ -r $HB_CNF_HANDLER ]] && source "$HB_CNF_HANDLER"
fi

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
