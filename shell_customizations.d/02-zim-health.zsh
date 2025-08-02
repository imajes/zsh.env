# $ZDOTDIR/shell_customizations.d/02-zim-health.zsh - Zim freshness check

# Only in interactive shells
[[ -o interactive ]] || return 0

# Require zimfw to exist
(( $+commands[zimfw] )) || return 0

# What file represents "last update" (prefer zimfw.zsh, fallback to init.zsh)
_zim_probe=("${ZIM_HOME:-${ZDOTDIR:-$HOME}/.zim}/zimfw.zsh" "${ZIM_HOME:-${ZDOTDIR:-$HOME}/.zim}/init.zsh")
for f in "${_zim_probe[@]}"; do [[ -r "$f" ]] && _zim_ref="$f" && break; done
[[ -n $_zim_ref ]] || return 0

# Cross-platform mtime (macOS vs Linux)
_zim_mtime() {
  if [[ $(uname) == Darwin ]]; then
    stat -f %m "$1" 2>/dev/null
  else
    stat -c %Y "$1" 2>/dev/null
  fi
}

zmodload -F zsh/datetime 2>/dev/null || return 0
ref_ts=$(_zim_mtime "$_zim_ref") || return 0
now_ts=$EPOCHSECONDS
age_days=$(( (now_ts - ref_ts) / 86400 ))

# Warn at 90+ days, but at most once per day
cache="${XDG_CACHE_HOME:-$HOME/.cache}/zimfw-stale-check"
today=$(printf '%(%Y-%m-%d)T' -1)
[[ -r "$cache" ]] && read -r last_day < "$cache"
[[ "$last_day" == "$today" ]] && return 0  # already warned today
: > "$cache" && print -r -- "$today" >| "$cache" 2>/dev/null

threshold=${ZIMFW_STALE_THRESHOLD_DAYS:-90}
(( age_days >= threshold )) || return 0

cat <<'MSG' >&2
⚠️  Zim looks stale (last core file update ≥ 90 days ago).
   Consider refreshing your modules:
     zimfw update && zimfw install && zimfw clean

   Tuning:
     • Set ZIMFW_STALE_THRESHOLD_DAYS to change 90d threshold.
     • Touch/clear ~/.cache/zimfw-stale-check to reset today's notice.
     • Export ZIMFW_STALE_SILENCE=1 to disable (or remove this file).
MSG
