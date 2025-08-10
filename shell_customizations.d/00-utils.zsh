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
autoload -Uz add-zsh-hook path:_enforce_pins

# Run on every prompt; tools that prepend/append get corrected immediately
add-zsh-hook precmd path:_enforce_pins

# Optional: also on directory change (some tools tweak PATH there)
add-zsh-hook chpwd  path:_enforce_pins
