# Zim's core-file age is a reminder, not a statement about module versions.
() {
  emulate -L zsh
  [[ -o interactive && ${ZIMFW_STALE_SILENCE:-0} != 1 ]] || return 0
  (( $+functions[zimfw] || $+commands[zimfw] )) || return 0
  local root=${ZIM_HOME:-${ZDOTDIR:-$HOME}/.zim} ref='' file
  local threshold=${ZIMFW_STALE_THRESHOLD_DAYS:-90} today last_day=''
  local cache="${XDG_CACHE_HOME:-$HOME/.cache}/zimfw-stale-check"
  local -A metadata
  [[ $threshold == <-> ]] || threshold=90
  for file in "$root/zimfw.zsh" "$root/init.zsh"; do
    [[ -r $file ]] && { ref=$file; break; }
  done
  [[ -n $ref ]] || return 0
  zmodload -F zsh/stat b:zstat && zmodload zsh/datetime || return 0
  zstat -H metadata -- "$ref" || return 0
  (( (EPOCHSECONDS - metadata[mtime]) / 86400 >= threshold )) || return 0
  strftime -s today '%Y-%m-%d' "$EPOCHSECONDS"
  [[ -r $cache ]] && IFS= read -r last_day < "$cache"
  [[ $last_day == $today ]] && return 0
  print -ru2 -- "Zim core file is at least $threshold days old. Check: zimfw check-version; upgrade core: zimfw upgrade"
  print -ru2 -- 'Modules: zimfw check / zimfw update. Set ZIMFW_STALE_SILENCE=1 to silence this reminder.'
  command mkdir -p -- "${cache:h}" && print -r -- "$today" >| "$cache"
  return 0
}
