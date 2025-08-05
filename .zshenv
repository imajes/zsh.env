## This prevents compinit being run from /etc/zsh stuff.
skip_global_compinit=1

# here are other things.
export ZDOTDIR=$HOME/.config/zsh
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
