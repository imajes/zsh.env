# # ---------- Config ----------
# : ${SECRETS_FILE:="$HOME/.secrets.yml"}        # primary
# : ${SECRETS_FILE_JSON:="$HOME/.secrets.json"}  # fallback
# autoload -Uz add-zsh-hook
# set -o rematchpcre
#
# # ---------- State ----------
# typeset -A SECRET_MAP   # name -> provider-uri
# typeset -A SECRET_MTIME # track file mtimes so we can auto-reload
#
# # ---------- Loaders ----------
# _secrets_file_mtime() { [[ -f "$1" ]] && stat -f %m "$1" 2>/dev/null || echo 0 }
#
# _secret_load_map() {
#   # Load once, or reload if file changed.
#   local y="$SECRETS_FILE" j="$SECRETS_FILE_JSON" mty mtj
#   mty=$(_secrets_file_mtime "$y")
#   mtj=$(_secrets_file_mtime "$j")
#
#   # If map exists and mtimes match, skip.
#   if (( ${#SECRET_MAP} )) && [[ "${SECRET_MTIME[$y]:-}" == "$mty" && "${SECRET_MTIME[$j]:-}" == "$mtj" ]]; then
#     return 0
#   fi
#
#   # Reset and (re)load
#   SECRET_MAP=()
#
#   if [[ -f "$y" ]]; then
#     # Use Ruby stdlib YAML (no extra deps)
#     while IFS=$'\t' read -r k v; do
#       [[ -n "$k" ]] && SECRET_MAP[$k]="$v"
#     done < <(
#       ruby -ryaml -e '
#         data = YAML.safe_load_file(ARGV[0], permitted_classes: [], aliases: true) || {}
#         data.each { |k,v| puts "#{k}\t#{v}" }
#       ' "$y" 2>/dev/null
#     )
#   elif [[ -f "$j" ]]; then
#     while IFS=$'\t' read -r k v; do
#       [[ -n "$k" ]] && SECRET_MAP[$k]="$v"
#     done < <(
#       ruby -rjson -e '
#         data = JSON.parse(File.read(ARGV[0])) rescue {}
#         data.each { |k,v| puts "#{k}\t#{v}" }
#       ' "$j" 2>/dev/null
#     )
#   fi
#
#   SECRET_MTIME[$y]="$mty"
#   SECRET_MTIME[$j]="$mtj"
# }
#
# # Extract placeholder name from a value like: 1pass(:name)
# _secret_placeholder_name() {
#   local cur="$1"
#   [[ "$cur" == 1pass\(:*\) ]] || return 1
#   printf '%s' "${cur#1pass(:}"; printf '%s' "${REPLY%) }" >/dev/null 2>&1
#   # Simpler:
#   printf '%s' "${cur#1pass(:}" | sed 's/)$//'
# }
#
# # Resolve name -> provider-uri from map
# _secret_path_for_name() {
#   _secret_load_map
#   printf '%s' "${SECRET_MAP[$1]}"
# }
#
# # Provider readers
# _secret_read_by_path() {
#   local path="$1" out
#   case "$path" in
#     op://*)
#       out="$(op read "$path" 2>/dev/null)" || return 1
#       printf '%s' "$out"
#       ;;
#     env://*)
#       local ref="${path#env://}"
#       printf '%s' "${(P)ref}"
#       ;;
#     cmd://*)
#       local cmd="${path#cmd://}"
#       # shellcheck disable=SC2086
#       out="$(eval "$cmd" 2>/dev/null)" || return 1
#       printf '%s' "$out"
#       ;;
#     *)
#       # Allow literal plaintext as last resort (not recommended)
#       printf '%s' "$path"
#       ;;
#   esac
# }
#
# # ---------- Resolution (no export) ----------
# # Return the concrete value of $VAR if it's a placeholder; print to stdout.
# _secret_resolve_value() {
#   local var="$1" cur name path val
#   cur="${(P)var)}"
#   name="$(_secret_placeholder_name "$cur")" || return 1
#   path="$(_secret_path_for_name "$name")"
#   [[ -z "$path" ]] && { print -r -- "⚠️ No mapping for '$name' (var $var) in $SECRETS_FILE"; return 1; }
#   val="$(_secret_read_by_path "$path")" || { print -r -- "⚠️ Failed to read secret '$name' (provider: $path)"; return 1; }
#   printf '%s' "$val"
# }
#
# # ---------- Resolution (export) ----------
# # If $VAR is a placeholder, fetch and export (replace value in env).
# _secret_export_if_placeholder() {
#   local var="$1" val
#   val="$(_secret_resolve_value "$var")" || return 1
#   typeset -gx "${var}=${val}"
# }
#
# # ---------- preexec hook ----------
# _secret_resolver_preexec() {
#   [[ -z "$1" ]] && return 0
#   local line="$1" rest="$1" var
#
#   # 1) Resolve $VAR / ${VAR…} occurrences
#   while [[ "$rest" =~ '\$(?:\{)?([A-Za-z_][A-Za-z0-9_]*)' ]]; do
#     var="${match[1]}"
#     _secret_export_if_placeholder "$var" || true
#     rest="${rest#$MATCH}"
#   done
#
#   # 2) Resolve inline VAR=… assignments (so that value is concrete before exec)
#   rest="$line"
#   while [[ "$rest" =~ '(^|\s)([A-Za-z_][A-Za-z0-9_]*)=' ]]; do
#     var="${match[2]}"
#     _secret_export_if_placeholder "$var" || true
#     rest="${rest#$MATCH}"
#   done
# }
# add-zsh-hook preexec _secret_resolver_preexec
#
# # ---------- Helpers ----------
# # Prime all placeholder-backed vars once per session
# secrets_prime() {
#   local k
#   for k in ${(k)parameters}; do
#     if [[ "$k" == [A-Z_][A-Z0-9_]* ]]; then
#       _secret_export_if_placeholder "$k" >/dev/null || true
#     fi
#   done
#   echo "🔐 Secrets primed (where placeholders were present)."
# }
#
# # Edit the secrets file (create a starter if missing)
# secrets_edit() {
#   local f="$SECRETS_FILE"
#   if [[ ! -f "$f" && ! -f "$SECRETS_FILE_JSON" ]]; then
#     cat > "$f" <<'YML'
# # ~/.secrets.yml
# # name: provider-uri
# # Examples:
# # anthropic_general: "op://private/ITEM/credential"
# # openai_default:    "op://work/ITEM/token"
# # github_personal:   "env://GITHUB_TOKEN"
# # legacy_migration:  "cmd://security find-generic-password -a you -s legacy -w"
# YML
#     echo "Created $f"
#   fi
#   ${EDITOR:-vi} "$f"
# }
#
# # Run a command with secrets injected but without exporting globally.
# # Usage: with_secrets VAR1 VAR2 -- your_command args...
# with_secrets() {
#   local -a envargs
#   local var val
#   while (( $# )); do
#     [[ "$1" == -- ]] && shift && break
#     var="$1"; shift
#     if val="$(_secret_resolve_value "$var")"; then
#       envargs+=("${var}=${val}")
#     else
#       # If not a placeholder, fall back to current value
#       envargs+=("${var}=${(P)var)}")
#     fi
#   done
#   command env "${envargs[@]}" "$@"
# }
