# Prepare functions and completions before Zim initializes compinit.
() {
  emulate -L zsh
  local funcdir="$ZDOTDIR/functions" file
  local site_functions="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions"
  typeset -gU path fpath
  [[ -d $site_functions ]] && fpath=("$site_functions" "${fpath[@]}")
  [[ -d $funcdir ]] && fpath=("$funcdir" "${fpath[@]}")

  # Source files stay immutable. In particular, never compile .zwc beside them.
  for file in "$funcdir"/*(.N); do
    [[ ${file:t} == _* || $file == *.zwc || $file == *.zwc.old ]] && continue
    autoload -Uz -- "${file:t}"
  done

  typeset -g ZSH_COMPLETION_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
  command mkdir -p -m 700 -- "$ZSH_COMPLETION_CACHE" || return
  fpath=("$ZSH_COMPLETION_CACHE" "${fpath[@]}")
  zstyle ':zim:completion' dumpfile "${ZSH_COMPLETION_CACHE:h}/zcompdump-$ZSH_VERSION"
  zstyle ':completion:*' cache-path "${ZSH_COMPLETION_CACHE:h}/completion-data"

  (( $+commands[mise] )) && completion:cache _mise "${commands[mise]}" complete --shell zsh
  (( $+commands[codex-helm] )) && completion:cache _codex-helm "${commands[codex-helm]}" completions zsh
  # op initializes its daemon/config even for completion generation. Never invoke
  # it during startup; compinit can use an existing cached or installed _op file.
  return 0
}
