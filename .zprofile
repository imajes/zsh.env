
# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Login command runners do not read .zshrc. Apply the same base ordering after
# macOS path_helper and app integration; interactive mise activation stays in .zshrc.
source "${ZDOTDIR:-$HOME/.config/zsh}/shell_customizations.d/01-path.zsh"
