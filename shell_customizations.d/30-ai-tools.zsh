# Run only if `codex-helm` exists
(( ${+commands[codex-helm]} )) && () {
  local command=${commands[codex-helm]}

  # ---- Cache / activation ----
  local cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/codex-helm
  mkdir -p "$cache_dir" "$cache_dir/functions"
  # ---- Completions ----
  # Prefer a writable directory already in $fpath; fall back to cache_dir/functions
  local compdir=
  for d in $fpath; do
    [[ -w $d ]] && compdir=$d && break
  done
  [[ -z $compdir ]] && compdir="$cache_dir/functions" && fpath=("$compdir" $fpath)
  mkdir -p "$compdir"

  local compfile="$compdir/_codex_helm"
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    "$command" completions zsh >| "$compfile"
    print -u2 -PR "* Regenerated codex-helm completions in $compdir"
  fi
}
