# $ZDOTDIR/shell_customizations.d/20-auth.zsh - 1Password helpers & secret fetch
# (safe to version-control; contains no plaintext secrets)

# Load 1Password shell plugins if present
[[ -f $HOME/.op/plugins.sh ]] && source $HOME/.op/plugins.sh

# # Fetch secrets only if logged in
# if (( $+commands[op] )) && op account list --session >/dev/null 2>&1; then
#   export ANTHROPIC_API_KEY=$(op read op://private/naxaks662uhvpfzksird4c25ki/credential  2>/dev/null)
#   export GROQ_API_KEY=$(op read op://private/z2imvufnnpcz7tkvsxkikykfzu/credential 2>/dev/null)
# fi

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
