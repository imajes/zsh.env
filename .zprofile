
# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
if [[ $OSTYPE == darwin* && -r $HOME/.orbstack/shell/init.zsh ]]; then
  source "$HOME/.orbstack/shell/init.zsh"
fi

# Login command runners do not read .zshrc. Apply the same base ordering after
# macOS path_helper and app integration; interactive mise activation stays in .zshrc.
source "${ZDOTDIR:-$HOME/.config/zsh}/shell_customizations.d/01-path.zsh"
