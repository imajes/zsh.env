# 00-path-utils.zsh — tiny bootstrapper
#
fpath=("~/.local/share/zsh/site-functions" $fpath)

local funcdir=$ZDOTDIR/functions
[[ -d $funcdir ]] || mkdir -p -- "$funcdir"
fpath=($funcdir $fpath)

# --- Source the compile helper directly (once), then use it ---
source -- "$funcdir/util:compile_functions_if_stale"

# Run the compiler if available
# command -v util:compile_functions_if_stale >/dev/null && util:compile_functions_if_stale "$funcdir"
util:compile_functions_if_stale "$funcdir"
util:compile_functions_if_stale "$HOME/.local/share/zsh/site-functions"

# Register all function files for lazy autoload (skip .zwc)
setopt localoptions extendedglob
autoload -Uz -- $funcdir/^*.zwc(.N:t)

# Ensure PATH<->path sync is de-duped, first occurrence wins
typeset -gU path fpath
# PATH order is established once before mise activation. Prompt/cd pinning
# would move user bins ahead of active project tools and virtual environments.
