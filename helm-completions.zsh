#compdef codex-helm

autoload -U is-at-least

_codex-helm() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_codex-helm_commands" \
"*::: :->codex-helm" \
&& ret=0
    case $state in
    (codex-helm)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-command-$line[1]:"
        case $line[1] in
            (db)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__db_commands" \
"*::: :->db" \
&& ret=0

    case $state in
    (db)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-db-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__db__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-db-help-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(ingest)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__ingest_commands" \
"*::: :->ingest" \
&& ret=0

    case $state in
    (ingest)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-ingest-command-$line[1]:"
        case $line[1] in
            (fixture)
_arguments "${_arguments_options[@]}" : \
'--fixture=[Path to a fixture knowledge JSON file]:FIXTURE:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__ingest__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-ingest-help-command-$line[1]:"
        case $line[1] in
            (fixture)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(knowledge)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__knowledge_commands" \
"*::: :->knowledge" \
&& ret=0

    case $state in
    (knowledge)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-knowledge-command-$line[1]:"
        case $line[1] in
            (schema)
_arguments "${_arguments_options[@]}" : \
'--output=[Output path for the knowledge bundle JSON Schema. Prints the schema when omitted]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(build)
_arguments "${_arguments_options[@]}" : \
'--codex-root=[Path to a Codex source checkout]:CODEX_ROOT:_files' \
'--output=[Output knowledge bundle JSON path]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(import)
_arguments "${_arguments_options[@]}" : \
'--input=[Path to a generated knowledge bundle JSON file]:INPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
'--input=[Path to a generated knowledge bundle JSON file]:INPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(manifest)
_arguments "${_arguments_options[@]}" : \
'--input=[Path to a generated knowledge bundle JSON file]:INPUT:_files' \
'--channel=[Distribution channel for this manifest, such as local, upstream-main, or release]:CHANNEL:_default' \
'--upstream-ref=[Upstream Codex ref used to build this bundle, such as main or codex-v1.2.3]:UPSTREAM_REF:_default' \
'--created-at=[RFC3339 UTC timestamp for deterministic publishing metadata]:CREATED_AT:_default' \
'--output=[Output path for the portable knowledge manifest JSON]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(pack)
_arguments "${_arguments_options[@]}" : \
'--input=[Path to a generated knowledge bundle JSON file]:INPUT:_files' \
'--channel=[Distribution channel for this package, such as local, upstream-main, or release]:CHANNEL:_default' \
'--upstream-ref=[Upstream Codex ref used to build this bundle, such as main or codex-v1.2.3]:UPSTREAM_REF:_default' \
'--created-at=[RFC3339 UTC timestamp for deterministic publishing metadata]:CREATED_AT:_default' \
'--output-dir=[Output directory for knowledge.json and knowledge.manifest.json]:OUTPUT_DIR:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(update)
_arguments "${_arguments_options[@]}" : \
'--bundle=[Path to a local knowledge bundle JSON file]:BUNDLE:_files' \
'--manifest=[Optional manifest JSON produced by \`knowledge manifest\`]:MANIFEST:_files' \
'--bundle-dir=[Directory produced by \`knowledge pack\`]:BUNDLE_DIR:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(export)
_arguments "${_arguments_options[@]}" : \
'--output=[Output path for the latest imported knowledge bundle JSON file]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(refresh)
_arguments "${_arguments_options[@]}" : \
'--codex-root=[Path to a Codex source checkout]:CODEX_ROOT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(inspect)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(gaps)
_arguments "${_arguments_options[@]}" : \
'--surface=[Target surface key used to shape suggested enrichment searches]:SURFACE:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(enrich)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__knowledge__subcmd__enrich_commands" \
"*::: :->enrich" \
&& ret=0

    case $state in
    (enrich)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-knowledge-enrich-command-$line[1]:"
        case $line[1] in
            (promote)
_arguments "${_arguments_options[@]}" : \
'--candidate-id=[Candidate row id from \`llm import-output\`]:CANDIDATE_ID:_default' \
'--equivalent-shape=[Shared source shape for equivalent paths, such as FeaturesToml.memories]:EQUIVALENT_SHAPE:_default' \
'--reviewer=[Reviewer label stored in local provenance]:REVIEWER:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__knowledge__subcmd__enrich__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-knowledge-enrich-help-command-$line[1]:"
        case $line[1] in
            (promote)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(surfaces)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(groups)
_arguments "${_arguments_options[@]}" : \
'--surface=[Target surface key]:SURFACE:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(option)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
':path -- Config option path to explain:_default' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__knowledge__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-knowledge-help-command-$line[1]:"
        case $line[1] in
            (schema)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(build)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(import)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(manifest)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(pack)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(update)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(export)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(refresh)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(inspect)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(gaps)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(enrich)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__knowledge__subcmd__help__subcmd__enrich_commands" \
"*::: :->enrich" \
&& ret=0

    case $state in
    (enrich)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-knowledge-help-enrich-command-$line[1]:"
        case $line[1] in
            (promote)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(surfaces)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(groups)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(option)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(presets)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__presets_commands" \
"*::: :->presets" \
&& ret=0

    case $state in
    (presets)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-presets-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" : \
'--surface=[Target surface key]:SURFACE:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(explain)
_arguments "${_arguments_options[@]}" : \
'--surface=[Target surface key]:SURFACE:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
':preset -- Preset/posture key:_default' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__presets__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-presets-help-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(explain)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(rules)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__rules_commands" \
"*::: :->rules" \
&& ret=0

    case $state in
    (rules)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-rules-command-$line[1]:"
        case $line[1] in
            (schema)
_arguments "${_arguments_options[@]}" : \
'--output=[Output path for the rule-pack JSON Schema. Prints the schema when omitted]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(surfaces)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(migrations)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(conflicts)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(overlays)
_arguments "${_arguments_options[@]}" : \
'--surface=[Target surface key]:SURFACE:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(presets)
_arguments "${_arguments_options[@]}" : \
'--surface=[Target surface key]:SURFACE:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(export)
_arguments "${_arguments_options[@]}" : \
'--surface=[Target surface key]:SURFACE:_default' \
'--scope=[Rule-pack scope, usually local or team]:SCOPE:_default' \
'--output=[Output path for the rule-pack JSON artifact]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(import)
_arguments "${_arguments_options[@]}" : \
'--input=[Rule-pack JSON artifact path]:INPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
'--input=[Rule-pack JSON artifact path]:INPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__rules__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-rules-help-command-$line[1]:"
        case $line[1] in
            (schema)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(surfaces)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(migrations)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(conflicts)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(overlays)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(presets)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(export)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(import)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(guide)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__guide_commands" \
"*::: :->guide" \
&& ret=0

    case $state in
    (guide)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-guide-command-$line[1]:"
        case $line[1] in
            (groups)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--sources-artifact=[Read config source stack from a config-sources artifact]:SOURCES_ARTIFACT:_files' \
'*--config-source=[Config source key to parse; repeat to parse an ordered overlay stack]:CONFIG_SOURCE:_default' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--output=[Optional output path for the full guide-groups artifact]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(flow)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--sources-artifact=[Read config source stack from a config-sources artifact]:SOURCES_ARTIFACT:_files' \
'*--config-source=[Config source key to parse; repeat to parse an ordered overlay stack]:CONFIG_SOURCE:_default' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--group=[Imported option group key, such as model-provider or approval-sandbox]:GROUP:_default' \
'*--choice=[Proposed choice in option_path=json form; repeat for multiple choices]:CHOICES:_default' \
'--plan-output=[Optional output path for a full config-plan artifact using this flow'\''s source stack]:PLAN_OUTPUT:_files' \
'--state-output=[Optional output path for a resumable guide-state artifact]:STATE_OUTPUT:_files' \
'--output=[Optional output path for the full guide-flow artifact]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(resume)
_arguments "${_arguments_options[@]}" : \
'--state=[Guide-state artifact produced by guide flow --state-output]:STATE:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__guide__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-guide-help-command-$line[1]:"
        case $line[1] in
            (groups)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(flow)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(resume)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(tui)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__tui_commands" \
"*::: :->tui" \
&& ret=0

    case $state in
    (tui)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-tui-command-$line[1]:"
        case $line[1] in
            (preview)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--codex-root=[Refresh knowledge from a local Codex source checkout before previewing]:CODEX_ROOT:_files' \
'--knowledge-bundle=[Import a generated knowledge bundle before previewing]:KNOWLEDGE_BUNDLE:_files' \
'--knowledge-bundle-dir=[Import a packaged knowledge bundle directory produced by knowledge pack before previewing]:KNOWLEDGE_BUNDLE_DIR:_files' \
'--sources-artifact=[Read config source stack from a config-sources artifact]:SOURCES_ARTIFACT:_files' \
'*--config-source=[Config source key to parse; repeat to parse an ordered overlay stack]:CONFIG_SOURCE:_default' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--guide-group=[Optional guide group to open and include in the preview response]:GUIDE_GROUP:_default' \
'*--choice=[Proposed guided choice in option_path=json form. Repeat to validate several choices]:CHOICES:_default' \
'--output=[Optional output path for the full TUI preview artifact]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(run)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--codex-root=[Refresh knowledge from a local Codex source checkout before running the terminal loop]:CODEX_ROOT:_files' \
'--knowledge-bundle=[Import a generated knowledge bundle before running the terminal loop]:KNOWLEDGE_BUNDLE:_files' \
'--knowledge-bundle-dir=[Import a packaged knowledge bundle directory produced by knowledge pack before running the terminal loop]:KNOWLEDGE_BUNDLE_DIR:_files' \
'--sources-artifact=[Read config source stack from a config-sources artifact]:SOURCES_ARTIFACT:_files' \
'*--config-source=[Config source key to parse; repeat to parse an ordered overlay stack]:CONFIG_SOURCE:_default' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--guide-group=[Optional guide group to open when the terminal UI starts]:GUIDE_GROUP:_default' \
'*--choice=[Proposed guided choice in option_path=json form. Repeat to validate several choices]:CHOICES:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(apply-effect)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--codex-root=[Refresh knowledge from a local Codex source checkout before applying the effect]:CODEX_ROOT:_files' \
'--knowledge-bundle=[Import a generated knowledge bundle before applying the effect]:KNOWLEDGE_BUNDLE:_files' \
'--knowledge-bundle-dir=[Import a packaged knowledge bundle directory produced by knowledge pack before applying the effect]:KNOWLEDGE_BUNDLE_DIR:_files' \
'--sources-artifact=[Read config source stack from a config-sources artifact]:SOURCES_ARTIFACT:_files' \
'--plan=[Reviewed config-plan artifact to guard a confirm-write effect against drift]:PLAN:_files' \
'*--config-source=[Config source key to parse; repeat to parse an ordered overlay stack]:CONFIG_SOURCE:_default' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--effect=[TUI effect to apply]:EFFECT:(confirm-write revert-snapshot stage-guide-choice)' \
'--snapshot=[Snapshot id carried by a revert-snapshot effect]:SNAPSHOT:_default' \
'--guide-group=[Option group key carried by a stage-guide-choice effect]:GUIDE_GROUP:_default' \
'--choice=[Staged guide choice in option_path=json form]:CHOICE:_default' \
'--plan-output=[Output path for a reviewed plan generated from a staged guide choice]:PLAN_OUTPUT:_files' \
'--platform=[Platform label stored with the pre-write snapshot]:PLATFORM:_default' \
'--reason=[Reason stored with the pre-write snapshot]:REASON:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--confirm-write[Confirm that Codex Helm may write CODEX_HOME/config.toml after snapshotting it]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__tui__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-tui-help-command-$line[1]:"
        case $line[1] in
            (preview)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(run)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(apply-effect)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(analysis)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__analysis_commands" \
"*::: :->analysis" \
&& ret=0

    case $state in
    (analysis)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-analysis-command-$line[1]:"
        case $line[1] in
            (runs)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__analysis__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-analysis-help-command-$line[1]:"
        case $line[1] in
            (runs)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(artifact)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__artifact_commands" \
"*::: :->artifact" \
&& ret=0

    case $state in
    (artifact)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-artifact-command-$line[1]:"
        case $line[1] in
            (schema)
_arguments "${_arguments_options[@]}" : \
'--kind=[Artifact kind\: artifact-schema-bundle, config-sources, config-values, config-plan, config-prepare, config-prepare-manifest, support-bundle, guide-groups, guide-flow, guide-state, or tui-preview]:KIND:_default' \
'--output=[Output path for the artifact JSON Schema. Prints the schema when omitted]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(schema-bundle)
_arguments "${_arguments_options[@]}" : \
'--output=[Output path for the artifact schema bundle. Prints the bundle when omitted]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
'--kind=[Artifact kind\: artifact-schema-bundle, config-sources, config-values, config-plan, config-prepare, config-prepare-manifest, support-bundle, guide-groups, guide-flow, guide-state, or tui-preview]:KIND:_default' \
'--input=[Input artifact JSON path]:INPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__artifact__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-artifact-help-command-$line[1]:"
        case $line[1] in
            (schema)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(schema-bundle)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(config)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__config_commands" \
"*::: :->config" \
&& ret=0

    case $state in
    (config)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-config-command-$line[1]:"
        case $line[1] in
            (sources)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME whose config source files should be inventoried]:CODEX_HOME:_files' \
'--output=[Output path for the config source artifact. Prints the full artifact when omitted]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(import)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--sources-artifact=[Config sources artifact JSON produced by config sources --output. Uses recommended_config_source_stack]:SOURCES_ARTIFACT:_files' \
'*--config-source=[Config source key to parse. Repeat for ordered overlay stacks; defaults to active]:CONFIG_SOURCE:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--include-values[Include redacted parsed values in the JSON response]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(posture)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME to parse and summarize against imported knowledge]:CODEX_HOME:_files' \
'--sources-artifact=[Config sources artifact JSON produced by config sources --output. Uses recommended_config_source_stack]:SOURCES_ARTIFACT:_files' \
'*--config-source=[Config source key to parse. Repeat for ordered overlay stacks; defaults to active]:CONFIG_SOURCE:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--include-layers[Include profile, MCP server, and feature-flag layer arrays]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(surface-drift)
_arguments "${_arguments_options[@]}" : \
'--before-codex-home=[CODEX_HOME before the target surface started]:BEFORE_CODEX_HOME:_files' \
'--after-codex-home=[CODEX_HOME after the target surface started]:AFTER_CODEX_HOME:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'*--config-source=[Config source key to parse for both homes. Repeat for ordered overlay stacks]:CONFIG_SOURCE:_default' \
'--output=[Output path for the generated runtime surface drift artifact]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(prepare)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME to prepare for app-facing posture and plan inspection]:CODEX_HOME:_files' \
'--codex-root=[Refresh knowledge from a local Codex source checkout before preparing]:CODEX_ROOT:_files' \
'--knowledge-bundle=[Import a generated knowledge bundle before preparing]:KNOWLEDGE_BUNDLE:_files' \
'--knowledge-bundle-dir=[Import a packaged knowledge bundle directory produced by knowledge pack before preparing]:KNOWLEDGE_BUNDLE_DIR:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'*--config-source=[Config source key to parse. Repeat for ordered overlay stacks; defaults to discovered recommendation]:CONFIG_SOURCE:_default' \
'--sources-artifact=[Config sources artifact JSON produced by config sources --output. Uses recommended_config_source_stack]:SOURCES_ARTIFACT:_files' \
'--sources-output=[Output path for the generated config sources artifact]:SOURCES_OUTPUT:_files' \
'--values-output=[Output path for the generated config values artifact]:VALUES_OUTPUT:_files' \
'--plan-output=[Output path for the generated config plan artifact]:PLAN_OUTPUT:_files' \
'--support-output=[Output path for a sanitized support bundle using the prepared source stack]:SUPPORT_OUTPUT:_files' \
'--guide-groups-output=[Output path for the generated guide-groups selector artifact]:GUIDE_GROUPS_OUTPUT:_files' \
'--guide-flow-group=[Imported option group key to open for guide-flow and TUI-preview artifacts]:GUIDE_FLOW_GROUP:_default' \
'*--guide-choice=[Proposed opened-flow choice in option_path=json form. Repeat to validate several choices]:GUIDE_CHOICES:_default' \
'--guide-flow-output=[Output path for the generated opened guide-flow artifact]:GUIDE_FLOW_OUTPUT:_files' \
'--guide-state-output=[Output path for the generated resumable guide-state artifact]:GUIDE_STATE_OUTPUT:_files' \
'--tui-preview-output=[Output path for the generated TUI preview artifact]:TUI_PREVIEW_OUTPUT:_files' \
'--schema-bundle-output=[Output path for the generated artifact schema bundle]:SCHEMA_BUNDLE_OUTPUT:_files' \
'--manifest-output=[Output path for the generated prepare artifact-set manifest]:MANIFEST_OUTPUT:_files' \
'--output=[Output path for the full prepare artifact. Prints the full artifact when omitted]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--include-layers[Include profile, MCP server, and feature-flag layer arrays in the nested posture]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(values)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME whose imported config values should be listed]:CODEX_HOME:_files' \
'--sources-artifact=[Config sources artifact JSON produced by config sources --output. Uses recommended_config_source_stack]:SOURCES_ARTIFACT:_files' \
'*--config-source=[Config source key to parse before listing values. Repeat for ordered overlay stacks]:CONFIG_SOURCE:_default' \
'--output=[Output path for the generated config values artifact]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--include-knowledge[Include matched knowledge metadata for each parsed value]' \
'--summary-only[Return only posture summary counts, omitting value and layer rows]' \
'--include-layers[Include profile, MCP server, and feature-flag layer arrays]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(plan)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME whose proposed user-preserving update should be planned]:CODEX_HOME:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'*--config-source=[Config source key to parse. Repeat for ordered overlay stacks; defaults to active]:CONFIG_SOURCE:_default' \
'--sources-artifact=[Config sources artifact JSON produced by config sources --output. Uses recommended_config_source_stack]:SOURCES_ARTIFACT:_files' \
'--write-policy=[Write-safety policy embedded in the plan artifact]:WRITE_POLICY:(confirm-required review-only)' \
'--output=[Output path for the plan JSON artifact. Prints the full plan when omitted]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(apply)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME whose config.toml should be updated from a ready plan]:CODEX_HOME:_files' \
'--plan=[Plan artifact JSON produced by config plan --output. When present, surface, preset, and config-source stack come from the plan]:PLAN:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'*--config-source=[Config source key to parse. Repeat for ordered overlay stacks; defaults to active]:CONFIG_SOURCE:_default' \
'--sources-artifact=[Config sources artifact JSON produced by config sources --output. Uses recommended_config_source_stack]:SOURCES_ARTIFACT:_files' \
'--write-policy=[Write-safety policy for this apply attempt. Plan artifacts override this value]:WRITE_POLICY:(confirm-required review-only)' \
'--platform=[Platform label stored with the pre-write snapshot]:PLATFORM:_default' \
'--reason=[Reason stored with the pre-write snapshot]:REASON:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--confirm-write[Confirm that Codex Helm may write CODEX_HOME/config.toml after snapshotting it]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__config__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-config-help-command-$line[1]:"
        case $line[1] in
            (sources)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(import)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(posture)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(surface-drift)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(prepare)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(values)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(plan)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(apply)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(inspect)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--json[Emit JSON output]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(analyze)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--json[Emit JSON output]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--json[Emit JSON output]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(doctor)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--json[Emit JSON output]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(render)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__render_commands" \
"*::: :->render" \
&& ret=0

    case $state in
    (render)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-render-command-$line[1]:"
        case $line[1] in
            (clean)
_arguments "${_arguments_options[@]}" : \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--output=[Output TOML path]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(user)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME containing config.toml]:CODEX_HOME:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--output=[Output TOML path]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--dry-run[Preview the generated TOML diff without writing output]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__render__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-render-help-command-$line[1]:"
        case $line[1] in
            (clean)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(user)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(snapshot)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__snapshot_commands" \
"*::: :->snapshot" \
&& ret=0

    case $state in
    (snapshot)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-snapshot-command-$line[1]:"
        case $line[1] in
            (create)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME whose config.toml should be snapshotted]:CODEX_HOME:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'*--overlay=[Overlay layer key. Repeat for ordered stacks]:OVERLAY:_default' \
'--platform=[Platform label stored with the snapshot]:PLATFORM:_default' \
'--reason=[Reason stored with the snapshot]:REASON:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME whose snapshots should be listed]:CODEX_HOME:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--json[Emit JSON output]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(revert)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME whose config.toml should be restored]:CODEX_HOME:_files' \
'--snapshot=[Snapshot id to restore]:SNAPSHOT:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__snapshot__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-snapshot-help-command-$line[1]:"
        case $line[1] in
            (create)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(revert)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(support)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__support_commands" \
"*::: :->support" \
&& ret=0

    case $state in
    (support)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-support-command-$line[1]:"
        case $line[1] in
            (bundle)
_arguments "${_arguments_options[@]}" : \
'--codex-home=[CODEX_HOME whose posture should be exported]:CODEX_HOME:_files' \
'--surface=[Target surface key]:SURFACE:_default' \
'--preset=[Preset/posture key]:PRESET:_default' \
'--level=[Support bundle export level]:LEVEL:(summary standard)' \
'--output=[Output path for the sanitized support bundle JSON]:OUTPUT:_files' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(inspect)
_arguments "${_arguments_options[@]}" : \
'--input=[Support bundle JSON artifact to review before sharing]:INPUT:_files' \
'--format=[Output format for the review summary]:FORMAT:(json text)' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__support__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-support-help-command-$line[1]:"
        case $line[1] in
            (bundle)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(inspect)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(llm)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_codex-helm__subcmd__llm_commands" \
"*::: :->llm" \
&& ret=0

    case $state in
    (llm)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-llm-command-$line[1]:"
        case $line[1] in
            (preview)
_arguments "${_arguments_options[@]}" : \
'--input=[JSON context that would be sent to the enrichment provider]:INPUT:_files' \
'--purpose=[Purpose label for the enrichment request]:PURPOSE:_default' \
'--schema=[Expected structured-output schema identifier]:SCHEMA:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(enrich)
_arguments "${_arguments_options[@]}" : \
'--input=[JSON context to send to Codex after local redaction review]:INPUT:_files' \
'--purpose=[Purpose label for the enrichment request]:PURPOSE:_default' \
'--schema=[Expected structured-output schema identifier]:SCHEMA:_default' \
'--codex-bin=[Codex executable to invoke]:CODEX_BIN:_files' \
'--codex-home=[CODEX_HOME to provide to the Codex executable]:CODEX_HOME:_files' \
'--model=[Model passed through to \`codex exec --model\`]:MODEL:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--confirm-send[Confirm that the reviewed context may be sent to Codex]' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(validate-output)
_arguments "${_arguments_options[@]}" : \
'--input=[JSON output returned by an enrichment provider]:INPUT:_files' \
'--purpose=[Purpose label used for the enrichment request]:PURPOSE:_default' \
'--schema=[Expected structured-output schema identifier]:SCHEMA:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(import-output)
_arguments "${_arguments_options[@]}" : \
'--input=[JSON output returned by an enrichment provider]:INPUT:_files' \
'--purpose=[Purpose label used for the enrichment request]:PURPOSE:_default' \
'--schema=[Expected structured-output schema identifier]:SCHEMA:_default' \
'--run-id=[Optional LLM run id that produced this output]:RUN_ID:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(updates)
_arguments "${_arguments_options[@]}" : \
'--purpose=[Filter by purpose label]:PURPOSE:_default' \
'--schema=[Filter by structured-output schema identifier]:SCHEMA:_default' \
'--target-kind=[Filter by target kind, such as option, group, preset, or rule]:TARGET_KIND:_default' \
'--target-key=[Filter by target key, such as an option path or group key]:TARGET_KEY:_default' \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(runs)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__llm__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-llm-help-command-$line[1]:"
        case $line[1] in
            (preview)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(enrich)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(validate-output)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(import-output)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(updates)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(runs)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" : \
'--database=[Path to the local Codex Helm SQLite database. Defaults to \$CODEX_HOME/.helm/codex-helm.sqlite, or \$HOME/.codex/.helm/codex-helm.sqlite when CODEX_HOME is unset]:DATABASE:_files' \
'--offline[Disable network and LLM calls; use only local fixtures or knowledge data]' \
'-h[Print help]' \
'--help[Print help]' \
':shell -- Shell to generate completions for:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-command-$line[1]:"
        case $line[1] in
            (db)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__db_commands" \
"*::: :->db" \
&& ret=0

    case $state in
    (db)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-db-command-$line[1]:"
        case $line[1] in
            (init)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(ingest)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__ingest_commands" \
"*::: :->ingest" \
&& ret=0

    case $state in
    (ingest)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-ingest-command-$line[1]:"
        case $line[1] in
            (fixture)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(knowledge)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__knowledge_commands" \
"*::: :->knowledge" \
&& ret=0

    case $state in
    (knowledge)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-knowledge-command-$line[1]:"
        case $line[1] in
            (schema)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(build)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(import)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(manifest)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(pack)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(update)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(export)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(refresh)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(inspect)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(gaps)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(enrich)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__knowledge__subcmd__enrich_commands" \
"*::: :->enrich" \
&& ret=0

    case $state in
    (enrich)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-knowledge-enrich-command-$line[1]:"
        case $line[1] in
            (promote)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(surfaces)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(groups)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(option)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(presets)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__presets_commands" \
"*::: :->presets" \
&& ret=0

    case $state in
    (presets)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-presets-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(explain)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(rules)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__rules_commands" \
"*::: :->rules" \
&& ret=0

    case $state in
    (rules)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-rules-command-$line[1]:"
        case $line[1] in
            (schema)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(surfaces)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(migrations)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(conflicts)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(overlays)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(presets)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(export)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(import)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(guide)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__guide_commands" \
"*::: :->guide" \
&& ret=0

    case $state in
    (guide)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-guide-command-$line[1]:"
        case $line[1] in
            (groups)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(flow)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(resume)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(tui)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__tui_commands" \
"*::: :->tui" \
&& ret=0

    case $state in
    (tui)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-tui-command-$line[1]:"
        case $line[1] in
            (preview)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(run)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(apply-effect)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(analysis)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__analysis_commands" \
"*::: :->analysis" \
&& ret=0

    case $state in
    (analysis)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-analysis-command-$line[1]:"
        case $line[1] in
            (runs)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(artifact)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__artifact_commands" \
"*::: :->artifact" \
&& ret=0

    case $state in
    (artifact)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-artifact-command-$line[1]:"
        case $line[1] in
            (schema)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(schema-bundle)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(config)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__config_commands" \
"*::: :->config" \
&& ret=0

    case $state in
    (config)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-config-command-$line[1]:"
        case $line[1] in
            (sources)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(import)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(posture)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(surface-drift)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(prepare)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(values)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(plan)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(apply)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(inspect)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(analyze)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(validate)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(doctor)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(render)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__render_commands" \
"*::: :->render" \
&& ret=0

    case $state in
    (render)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-render-command-$line[1]:"
        case $line[1] in
            (clean)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(user)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(snapshot)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__snapshot_commands" \
"*::: :->snapshot" \
&& ret=0

    case $state in
    (snapshot)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-snapshot-command-$line[1]:"
        case $line[1] in
            (create)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(revert)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(support)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__support_commands" \
"*::: :->support" \
&& ret=0

    case $state in
    (support)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-support-command-$line[1]:"
        case $line[1] in
            (bundle)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(inspect)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(llm)
_arguments "${_arguments_options[@]}" : \
":: :_codex-helm__subcmd__help__subcmd__llm_commands" \
"*::: :->llm" \
&& ret=0

    case $state in
    (llm)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-helm-help-llm-command-$line[1]:"
        case $line[1] in
            (preview)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(enrich)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(validate-output)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(import-output)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(updates)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(runs)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_codex-helm_commands] )) ||
_codex-helm_commands() {
    local commands; commands=(
'db:Initialize a local Codex Helm SQLite database' \
'ingest:Ingest deterministic knowledge fixtures' \
'knowledge:Build, import, and inspect source-backed knowledge bundles' \
'presets:Inspect preset/posture decisions' \
'rules:Inspect data-backed rule packs' \
'guide:Emit JSON-first guided config flows' \
'tui:Preview or run the guarded terminal UI workflow' \
'analysis:Inspect persisted analysis history' \
'artifact:Emit and validate app-facing artifact schemas' \
'config:Import and summarize a Codex home config' \
'inspect:Inspect parsed Codex config values without applying a preset. Review a support bundle before sharing it' \
'analyze:Analyze a Codex home against ingested knowledge' \
'validate:Validate a Codex home and emit health findings' \
'doctor:Run a quick health check with default TUI/conservative posture' \
'render:Render generated TOML outputs' \
'snapshot:Manage config snapshots' \
'support:Export sanitized diagnostic artifacts' \
'llm:Preview optional LLM enrichment context without calling a provider' \
'completions:Emit shell completion scripts' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__analysis_commands] )) ||
_codex-helm__subcmd__analysis_commands() {
    local commands; commands=(
'runs:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm analysis commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__analysis__subcmd__help_commands] )) ||
_codex-helm__subcmd__analysis__subcmd__help_commands() {
    local commands; commands=(
'runs:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm analysis help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__analysis__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__analysis__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm analysis help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__analysis__subcmd__help__subcmd__runs_commands] )) ||
_codex-helm__subcmd__analysis__subcmd__help__subcmd__runs_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm analysis help runs commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__analysis__subcmd__runs_commands] )) ||
_codex-helm__subcmd__analysis__subcmd__runs_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm analysis runs commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__analyze_commands] )) ||
_codex-helm__subcmd__analyze_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm analyze commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__artifact_commands] )) ||
_codex-helm__subcmd__artifact_commands() {
    local commands; commands=(
'schema:Emit an app-facing artifact JSON Schema' \
'schema-bundle:Emit a bundled set of app-facing artifact JSON Schemas' \
'validate:Validate an app-facing artifact JSON file' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm artifact commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__artifact__subcmd__help_commands] )) ||
_codex-helm__subcmd__artifact__subcmd__help_commands() {
    local commands; commands=(
'schema:Emit an app-facing artifact JSON Schema' \
'schema-bundle:Emit a bundled set of app-facing artifact JSON Schemas' \
'validate:Validate an app-facing artifact JSON file' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm artifact help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__artifact__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__artifact__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm artifact help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__artifact__subcmd__help__subcmd__schema_commands] )) ||
_codex-helm__subcmd__artifact__subcmd__help__subcmd__schema_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm artifact help schema commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__artifact__subcmd__help__subcmd__schema-bundle_commands] )) ||
_codex-helm__subcmd__artifact__subcmd__help__subcmd__schema-bundle_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm artifact help schema-bundle commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__artifact__subcmd__help__subcmd__validate_commands] )) ||
_codex-helm__subcmd__artifact__subcmd__help__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm artifact help validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__artifact__subcmd__schema_commands] )) ||
_codex-helm__subcmd__artifact__subcmd__schema_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm artifact schema commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__artifact__subcmd__schema-bundle_commands] )) ||
_codex-helm__subcmd__artifact__subcmd__schema-bundle_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm artifact schema-bundle commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__artifact__subcmd__validate_commands] )) ||
_codex-helm__subcmd__artifact__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm artifact validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__completions_commands] )) ||
_codex-helm__subcmd__completions_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm completions commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config_commands] )) ||
_codex-helm__subcmd__config_commands() {
    local commands; commands=(
'sources:Inventory config source files for a CODEX_HOME' \
'import:Import CODEX_HOME config values into SQLite' \
'posture:Summarize current config posture against imported knowledge' \
'surface-drift:Compare before/after config homes and classify runtime surface drift' \
'prepare:Prepare app-facing source, posture, plan, and support artifacts' \
'values:List parsed config values for a CODEX_HOME' \
'plan:Build a guarded dry-run config plan' \
'apply:Apply a ready config plan behind confirmation and snapshot guards' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm config commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__apply_commands] )) ||
_codex-helm__subcmd__config__subcmd__apply_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config apply commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help_commands] )) ||
_codex-helm__subcmd__config__subcmd__help_commands() {
    local commands; commands=(
'sources:Inventory config source files for a CODEX_HOME' \
'import:Import CODEX_HOME config values into SQLite' \
'posture:Summarize current config posture against imported knowledge' \
'surface-drift:Compare before/after config homes and classify runtime surface drift' \
'prepare:Prepare app-facing source, posture, plan, and support artifacts' \
'values:List parsed config values for a CODEX_HOME' \
'plan:Build a guarded dry-run config plan' \
'apply:Apply a ready config plan behind confirmation and snapshot guards' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm config help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help__subcmd__apply_commands] )) ||
_codex-helm__subcmd__config__subcmd__help__subcmd__apply_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config help apply commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__config__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help__subcmd__import_commands] )) ||
_codex-helm__subcmd__config__subcmd__help__subcmd__import_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config help import commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help__subcmd__plan_commands] )) ||
_codex-helm__subcmd__config__subcmd__help__subcmd__plan_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config help plan commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help__subcmd__posture_commands] )) ||
_codex-helm__subcmd__config__subcmd__help__subcmd__posture_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config help posture commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help__subcmd__prepare_commands] )) ||
_codex-helm__subcmd__config__subcmd__help__subcmd__prepare_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config help prepare commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help__subcmd__sources_commands] )) ||
_codex-helm__subcmd__config__subcmd__help__subcmd__sources_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config help sources commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help__subcmd__surface-drift_commands] )) ||
_codex-helm__subcmd__config__subcmd__help__subcmd__surface-drift_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config help surface-drift commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__help__subcmd__values_commands] )) ||
_codex-helm__subcmd__config__subcmd__help__subcmd__values_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config help values commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__import_commands] )) ||
_codex-helm__subcmd__config__subcmd__import_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config import commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__plan_commands] )) ||
_codex-helm__subcmd__config__subcmd__plan_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config plan commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__posture_commands] )) ||
_codex-helm__subcmd__config__subcmd__posture_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config posture commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__prepare_commands] )) ||
_codex-helm__subcmd__config__subcmd__prepare_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config prepare commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__sources_commands] )) ||
_codex-helm__subcmd__config__subcmd__sources_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config sources commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__surface-drift_commands] )) ||
_codex-helm__subcmd__config__subcmd__surface-drift_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config surface-drift commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__config__subcmd__values_commands] )) ||
_codex-helm__subcmd__config__subcmd__values_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm config values commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__db_commands] )) ||
_codex-helm__subcmd__db_commands() {
    local commands; commands=(
'init:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm db commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__db__subcmd__help_commands] )) ||
_codex-helm__subcmd__db__subcmd__help_commands() {
    local commands; commands=(
'init:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm db help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__db__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__db__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm db help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__db__subcmd__help__subcmd__init_commands] )) ||
_codex-helm__subcmd__db__subcmd__help__subcmd__init_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm db help init commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__db__subcmd__init_commands] )) ||
_codex-helm__subcmd__db__subcmd__init_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm db init commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__doctor_commands] )) ||
_codex-helm__subcmd__doctor_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm doctor commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__guide_commands] )) ||
_codex-helm__subcmd__guide_commands() {
    local commands; commands=(
'groups:List selectable guided flows with current config state' \
'flow:Emit a guided flow for one imported option group' \
'resume:Resume from a guide-state artifact without reading or writing config' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm guide commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__guide__subcmd__flow_commands] )) ||
_codex-helm__subcmd__guide__subcmd__flow_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm guide flow commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__guide__subcmd__groups_commands] )) ||
_codex-helm__subcmd__guide__subcmd__groups_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm guide groups commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__guide__subcmd__help_commands] )) ||
_codex-helm__subcmd__guide__subcmd__help_commands() {
    local commands; commands=(
'groups:List selectable guided flows with current config state' \
'flow:Emit a guided flow for one imported option group' \
'resume:Resume from a guide-state artifact without reading or writing config' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm guide help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__guide__subcmd__help__subcmd__flow_commands] )) ||
_codex-helm__subcmd__guide__subcmd__help__subcmd__flow_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm guide help flow commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__guide__subcmd__help__subcmd__groups_commands] )) ||
_codex-helm__subcmd__guide__subcmd__help__subcmd__groups_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm guide help groups commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__guide__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__guide__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm guide help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__guide__subcmd__help__subcmd__resume_commands] )) ||
_codex-helm__subcmd__guide__subcmd__help__subcmd__resume_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm guide help resume commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__guide__subcmd__resume_commands] )) ||
_codex-helm__subcmd__guide__subcmd__resume_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm guide resume commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help_commands] )) ||
_codex-helm__subcmd__help_commands() {
    local commands; commands=(
'db:Initialize a local Codex Helm SQLite database' \
'ingest:Ingest deterministic knowledge fixtures' \
'knowledge:Build, import, and inspect source-backed knowledge bundles' \
'presets:Inspect preset/posture decisions' \
'rules:Inspect data-backed rule packs' \
'guide:Emit JSON-first guided config flows' \
'tui:Preview or run the guarded terminal UI workflow' \
'analysis:Inspect persisted analysis history' \
'artifact:Emit and validate app-facing artifact schemas' \
'config:Import and summarize a Codex home config' \
'inspect:Inspect parsed Codex config values without applying a preset. Review a support bundle before sharing it' \
'analyze:Analyze a Codex home against ingested knowledge' \
'validate:Validate a Codex home and emit health findings' \
'doctor:Run a quick health check with default TUI/conservative posture' \
'render:Render generated TOML outputs' \
'snapshot:Manage config snapshots' \
'support:Export sanitized diagnostic artifacts' \
'llm:Preview optional LLM enrichment context without calling a provider' \
'completions:Emit shell completion scripts' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__analysis_commands] )) ||
_codex-helm__subcmd__help__subcmd__analysis_commands() {
    local commands; commands=(
'runs:' \
    )
    _describe -t commands 'codex-helm help analysis commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__analysis__subcmd__runs_commands] )) ||
_codex-helm__subcmd__help__subcmd__analysis__subcmd__runs_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help analysis runs commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__analyze_commands] )) ||
_codex-helm__subcmd__help__subcmd__analyze_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help analyze commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__artifact_commands] )) ||
_codex-helm__subcmd__help__subcmd__artifact_commands() {
    local commands; commands=(
'schema:Emit an app-facing artifact JSON Schema' \
'schema-bundle:Emit a bundled set of app-facing artifact JSON Schemas' \
'validate:Validate an app-facing artifact JSON file' \
    )
    _describe -t commands 'codex-helm help artifact commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__artifact__subcmd__schema_commands] )) ||
_codex-helm__subcmd__help__subcmd__artifact__subcmd__schema_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help artifact schema commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__artifact__subcmd__schema-bundle_commands] )) ||
_codex-helm__subcmd__help__subcmd__artifact__subcmd__schema-bundle_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help artifact schema-bundle commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__artifact__subcmd__validate_commands] )) ||
_codex-helm__subcmd__help__subcmd__artifact__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help artifact validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__completions_commands] )) ||
_codex-helm__subcmd__help__subcmd__completions_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help completions commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__config_commands] )) ||
_codex-helm__subcmd__help__subcmd__config_commands() {
    local commands; commands=(
'sources:Inventory config source files for a CODEX_HOME' \
'import:Import CODEX_HOME config values into SQLite' \
'posture:Summarize current config posture against imported knowledge' \
'surface-drift:Compare before/after config homes and classify runtime surface drift' \
'prepare:Prepare app-facing source, posture, plan, and support artifacts' \
'values:List parsed config values for a CODEX_HOME' \
'plan:Build a guarded dry-run config plan' \
'apply:Apply a ready config plan behind confirmation and snapshot guards' \
    )
    _describe -t commands 'codex-helm help config commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__config__subcmd__apply_commands] )) ||
_codex-helm__subcmd__help__subcmd__config__subcmd__apply_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help config apply commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__config__subcmd__import_commands] )) ||
_codex-helm__subcmd__help__subcmd__config__subcmd__import_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help config import commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__config__subcmd__plan_commands] )) ||
_codex-helm__subcmd__help__subcmd__config__subcmd__plan_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help config plan commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__config__subcmd__posture_commands] )) ||
_codex-helm__subcmd__help__subcmd__config__subcmd__posture_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help config posture commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__config__subcmd__prepare_commands] )) ||
_codex-helm__subcmd__help__subcmd__config__subcmd__prepare_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help config prepare commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__config__subcmd__sources_commands] )) ||
_codex-helm__subcmd__help__subcmd__config__subcmd__sources_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help config sources commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__config__subcmd__surface-drift_commands] )) ||
_codex-helm__subcmd__help__subcmd__config__subcmd__surface-drift_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help config surface-drift commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__config__subcmd__values_commands] )) ||
_codex-helm__subcmd__help__subcmd__config__subcmd__values_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help config values commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__db_commands] )) ||
_codex-helm__subcmd__help__subcmd__db_commands() {
    local commands; commands=(
'init:' \
    )
    _describe -t commands 'codex-helm help db commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__db__subcmd__init_commands] )) ||
_codex-helm__subcmd__help__subcmd__db__subcmd__init_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help db init commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__doctor_commands] )) ||
_codex-helm__subcmd__help__subcmd__doctor_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help doctor commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__guide_commands] )) ||
_codex-helm__subcmd__help__subcmd__guide_commands() {
    local commands; commands=(
'groups:List selectable guided flows with current config state' \
'flow:Emit a guided flow for one imported option group' \
'resume:Resume from a guide-state artifact without reading or writing config' \
    )
    _describe -t commands 'codex-helm help guide commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__guide__subcmd__flow_commands] )) ||
_codex-helm__subcmd__help__subcmd__guide__subcmd__flow_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help guide flow commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__guide__subcmd__groups_commands] )) ||
_codex-helm__subcmd__help__subcmd__guide__subcmd__groups_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help guide groups commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__guide__subcmd__resume_commands] )) ||
_codex-helm__subcmd__help__subcmd__guide__subcmd__resume_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help guide resume commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__ingest_commands] )) ||
_codex-helm__subcmd__help__subcmd__ingest_commands() {
    local commands; commands=(
'fixture:' \
    )
    _describe -t commands 'codex-helm help ingest commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__ingest__subcmd__fixture_commands] )) ||
_codex-helm__subcmd__help__subcmd__ingest__subcmd__fixture_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help ingest fixture commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__inspect_commands] )) ||
_codex-helm__subcmd__help__subcmd__inspect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help inspect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge_commands() {
    local commands; commands=(
'schema:Emit the knowledge bundle JSON Schema' \
'build:Build source-backed knowledge from a local Codex checkout' \
'import:Import a local knowledge bundle into SQLite' \
'validate:Validate a knowledge bundle without importing it' \
'manifest:Create a portable manifest for an existing bundle' \
'pack:Package a bundle with its portable manifest' \
'update:Update SQLite from a bundle file or package directory' \
'export:Export the latest imported knowledge bundle' \
'refresh:Refresh SQLite knowledge from a local Codex checkout' \
'inspect:Inspect the latest imported knowledge summary' \
'gaps:Detect sparse or weak source-backed knowledge records' \
'enrich:Review and promote imported enrichment candidates into knowledge overlays' \
'surfaces:List source-backed app surfaces' \
'groups:List option groups for a surface' \
'option:Explain one imported config option' \
    )
    _describe -t commands 'codex-helm help knowledge commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__build_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__build_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge build commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__enrich_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__enrich_commands() {
    local commands; commands=(
'promote:Promote an imported LLM candidate into reviewed knowledge' \
    )
    _describe -t commands 'codex-helm help knowledge enrich commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__enrich__subcmd__promote_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__enrich__subcmd__promote_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge enrich promote commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__export_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__export_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge export commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__gaps_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__gaps_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge gaps commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__groups_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__groups_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge groups commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__import_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__import_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge import commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__inspect_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__inspect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge inspect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__manifest_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__manifest_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge manifest commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__option_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__option_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge option commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__pack_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__pack_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge pack commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__refresh_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__refresh_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge refresh commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__schema_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__schema_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge schema commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__surfaces_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__surfaces_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge surfaces commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__update_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__update_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge update commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__knowledge__subcmd__validate_commands] )) ||
_codex-helm__subcmd__help__subcmd__knowledge__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help knowledge validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__llm_commands] )) ||
_codex-helm__subcmd__help__subcmd__llm_commands() {
    local commands; commands=(
'preview:Review a JSON enrichment context before any provider call' \
'enrich:Run opt-in live enrichment through \`codex exec\`' \
'validate-output:Validate structured JSON output from an enrichment provider' \
'import-output:Import validated enrichment updates into local metadata' \
'updates:List imported enrichment updates' \
'runs:List local LLM enrichment preview/run metadata' \
    )
    _describe -t commands 'codex-helm help llm commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__llm__subcmd__enrich_commands] )) ||
_codex-helm__subcmd__help__subcmd__llm__subcmd__enrich_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help llm enrich commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__llm__subcmd__import-output_commands] )) ||
_codex-helm__subcmd__help__subcmd__llm__subcmd__import-output_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help llm import-output commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__llm__subcmd__preview_commands] )) ||
_codex-helm__subcmd__help__subcmd__llm__subcmd__preview_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help llm preview commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__llm__subcmd__runs_commands] )) ||
_codex-helm__subcmd__help__subcmd__llm__subcmd__runs_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help llm runs commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__llm__subcmd__updates_commands] )) ||
_codex-helm__subcmd__help__subcmd__llm__subcmd__updates_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help llm updates commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__llm__subcmd__validate-output_commands] )) ||
_codex-helm__subcmd__help__subcmd__llm__subcmd__validate-output_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help llm validate-output commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__presets_commands] )) ||
_codex-helm__subcmd__help__subcmd__presets_commands() {
    local commands; commands=(
'list:List available preset/posture decisions' \
'explain:Explain one preset/posture decision set' \
    )
    _describe -t commands 'codex-helm help presets commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__presets__subcmd__explain_commands] )) ||
_codex-helm__subcmd__help__subcmd__presets__subcmd__explain_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help presets explain commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__presets__subcmd__list_commands] )) ||
_codex-helm__subcmd__help__subcmd__presets__subcmd__list_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help presets list commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__render_commands] )) ||
_codex-helm__subcmd__help__subcmd__render_commands() {
    local commands; commands=(
'clean:Render clean generated TOML' \
'user:Render user-preserving TOML for a CODEX_HOME' \
    )
    _describe -t commands 'codex-helm help render commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__render__subcmd__clean_commands] )) ||
_codex-helm__subcmd__help__subcmd__render__subcmd__clean_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help render clean commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__render__subcmd__user_commands] )) ||
_codex-helm__subcmd__help__subcmd__render__subcmd__user_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help render user commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules_commands() {
    local commands; commands=(
'schema:Emit the portable rule-pack JSON Schema' \
'surfaces:List source-backed surface and overlay layer rules' \
'migrations:List data-backed migration rules' \
'conflicts:List data-backed conflict rules' \
'overlays:List overlay ownership/support rules for a surface' \
'presets:List preset evidence for a surface' \
'export:Export a portable local/team rule-pack' \
'import:Import policy records from a portable local/team rule-pack' \
'validate:Validate a portable local/team rule-pack without importing it' \
    )
    _describe -t commands 'codex-helm help rules commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules__subcmd__conflicts_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules__subcmd__conflicts_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help rules conflicts commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules__subcmd__export_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules__subcmd__export_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help rules export commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules__subcmd__import_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules__subcmd__import_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help rules import commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules__subcmd__migrations_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules__subcmd__migrations_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help rules migrations commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules__subcmd__overlays_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules__subcmd__overlays_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help rules overlays commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules__subcmd__presets_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules__subcmd__presets_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help rules presets commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules__subcmd__schema_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules__subcmd__schema_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help rules schema commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules__subcmd__surfaces_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules__subcmd__surfaces_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help rules surfaces commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__rules__subcmd__validate_commands] )) ||
_codex-helm__subcmd__help__subcmd__rules__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help rules validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__snapshot_commands] )) ||
_codex-helm__subcmd__help__subcmd__snapshot_commands() {
    local commands; commands=(
'create:Create a snapshot of CODEX_HOME/config.toml' \
'list:List snapshots for a CODEX_HOME' \
'revert:Restore CODEX_HOME/config.toml from a snapshot' \
    )
    _describe -t commands 'codex-helm help snapshot commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__snapshot__subcmd__create_commands] )) ||
_codex-helm__subcmd__help__subcmd__snapshot__subcmd__create_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help snapshot create commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__snapshot__subcmd__list_commands] )) ||
_codex-helm__subcmd__help__subcmd__snapshot__subcmd__list_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help snapshot list commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__snapshot__subcmd__revert_commands] )) ||
_codex-helm__subcmd__help__subcmd__snapshot__subcmd__revert_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help snapshot revert commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__support_commands] )) ||
_codex-helm__subcmd__help__subcmd__support_commands() {
    local commands; commands=(
'bundle:Export a sanitized support bundle' \
'inspect:Review a support bundle before sharing' \
    )
    _describe -t commands 'codex-helm help support commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__support__subcmd__bundle_commands] )) ||
_codex-helm__subcmd__help__subcmd__support__subcmd__bundle_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help support bundle commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__support__subcmd__inspect_commands] )) ||
_codex-helm__subcmd__help__subcmd__support__subcmd__inspect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help support inspect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__tui_commands] )) ||
_codex-helm__subcmd__help__subcmd__tui_commands() {
    local commands; commands=(
'preview:Build the current TUI screen model as JSON without starting a terminal' \
'run:Run the guarded terminal UI workflow without applying config writes' \
'apply-effect:Apply a safe TUI effect through the guarded CLI write path' \
    )
    _describe -t commands 'codex-helm help tui commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__tui__subcmd__apply-effect_commands] )) ||
_codex-helm__subcmd__help__subcmd__tui__subcmd__apply-effect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help tui apply-effect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__tui__subcmd__preview_commands] )) ||
_codex-helm__subcmd__help__subcmd__tui__subcmd__preview_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help tui preview commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__tui__subcmd__run_commands] )) ||
_codex-helm__subcmd__help__subcmd__tui__subcmd__run_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help tui run commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__help__subcmd__validate_commands] )) ||
_codex-helm__subcmd__help__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm help validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__ingest_commands] )) ||
_codex-helm__subcmd__ingest_commands() {
    local commands; commands=(
'fixture:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm ingest commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__ingest__subcmd__fixture_commands] )) ||
_codex-helm__subcmd__ingest__subcmd__fixture_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm ingest fixture commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__ingest__subcmd__help_commands] )) ||
_codex-helm__subcmd__ingest__subcmd__help_commands() {
    local commands; commands=(
'fixture:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm ingest help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__ingest__subcmd__help__subcmd__fixture_commands] )) ||
_codex-helm__subcmd__ingest__subcmd__help__subcmd__fixture_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm ingest help fixture commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__ingest__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__ingest__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm ingest help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__inspect_commands] )) ||
_codex-helm__subcmd__inspect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm inspect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge_commands] )) ||
_codex-helm__subcmd__knowledge_commands() {
    local commands; commands=(
'schema:Emit the knowledge bundle JSON Schema' \
'build:Build source-backed knowledge from a local Codex checkout' \
'import:Import a local knowledge bundle into SQLite' \
'validate:Validate a knowledge bundle without importing it' \
'manifest:Create a portable manifest for an existing bundle' \
'pack:Package a bundle with its portable manifest' \
'update:Update SQLite from a bundle file or package directory' \
'export:Export the latest imported knowledge bundle' \
'refresh:Refresh SQLite knowledge from a local Codex checkout' \
'inspect:Inspect the latest imported knowledge summary' \
'gaps:Detect sparse or weak source-backed knowledge records' \
'enrich:Review and promote imported enrichment candidates into knowledge overlays' \
'surfaces:List source-backed app surfaces' \
'groups:List option groups for a surface' \
'option:Explain one imported config option' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm knowledge commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__build_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__build_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge build commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__enrich_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__enrich_commands() {
    local commands; commands=(
'promote:Promote an imported LLM candidate into reviewed knowledge' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm knowledge enrich commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__enrich__subcmd__help_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__enrich__subcmd__help_commands() {
    local commands; commands=(
'promote:Promote an imported LLM candidate into reviewed knowledge' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm knowledge enrich help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__enrich__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__enrich__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge enrich help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__enrich__subcmd__help__subcmd__promote_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__enrich__subcmd__help__subcmd__promote_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge enrich help promote commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__enrich__subcmd__promote_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__enrich__subcmd__promote_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge enrich promote commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__export_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__export_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge export commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__gaps_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__gaps_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge gaps commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__groups_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__groups_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge groups commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help_commands() {
    local commands; commands=(
'schema:Emit the knowledge bundle JSON Schema' \
'build:Build source-backed knowledge from a local Codex checkout' \
'import:Import a local knowledge bundle into SQLite' \
'validate:Validate a knowledge bundle without importing it' \
'manifest:Create a portable manifest for an existing bundle' \
'pack:Package a bundle with its portable manifest' \
'update:Update SQLite from a bundle file or package directory' \
'export:Export the latest imported knowledge bundle' \
'refresh:Refresh SQLite knowledge from a local Codex checkout' \
'inspect:Inspect the latest imported knowledge summary' \
'gaps:Detect sparse or weak source-backed knowledge records' \
'enrich:Review and promote imported enrichment candidates into knowledge overlays' \
'surfaces:List source-backed app surfaces' \
'groups:List option groups for a surface' \
'option:Explain one imported config option' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm knowledge help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__build_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__build_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help build commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__enrich_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__enrich_commands() {
    local commands; commands=(
'promote:Promote an imported LLM candidate into reviewed knowledge' \
    )
    _describe -t commands 'codex-helm knowledge help enrich commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__enrich__subcmd__promote_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__enrich__subcmd__promote_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help enrich promote commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__export_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__export_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help export commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__gaps_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__gaps_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help gaps commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__groups_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__groups_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help groups commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__import_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__import_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help import commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__inspect_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__inspect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help inspect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__manifest_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__manifest_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help manifest commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__option_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__option_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help option commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__pack_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__pack_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help pack commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__refresh_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__refresh_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help refresh commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__schema_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__schema_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help schema commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__surfaces_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__surfaces_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help surfaces commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__update_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__update_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help update commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__help__subcmd__validate_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__help__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge help validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__import_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__import_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge import commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__inspect_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__inspect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge inspect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__manifest_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__manifest_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge manifest commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__option_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__option_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge option commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__pack_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__pack_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge pack commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__refresh_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__refresh_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge refresh commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__schema_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__schema_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge schema commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__surfaces_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__surfaces_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge surfaces commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__update_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__update_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge update commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__knowledge__subcmd__validate_commands] )) ||
_codex-helm__subcmd__knowledge__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm knowledge validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm_commands] )) ||
_codex-helm__subcmd__llm_commands() {
    local commands; commands=(
'preview:Review a JSON enrichment context before any provider call' \
'enrich:Run opt-in live enrichment through \`codex exec\`' \
'validate-output:Validate structured JSON output from an enrichment provider' \
'import-output:Import validated enrichment updates into local metadata' \
'updates:List imported enrichment updates' \
'runs:List local LLM enrichment preview/run metadata' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm llm commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__enrich_commands] )) ||
_codex-helm__subcmd__llm__subcmd__enrich_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm enrich commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__help_commands] )) ||
_codex-helm__subcmd__llm__subcmd__help_commands() {
    local commands; commands=(
'preview:Review a JSON enrichment context before any provider call' \
'enrich:Run opt-in live enrichment through \`codex exec\`' \
'validate-output:Validate structured JSON output from an enrichment provider' \
'import-output:Import validated enrichment updates into local metadata' \
'updates:List imported enrichment updates' \
'runs:List local LLM enrichment preview/run metadata' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm llm help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__help__subcmd__enrich_commands] )) ||
_codex-helm__subcmd__llm__subcmd__help__subcmd__enrich_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm help enrich commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__llm__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__help__subcmd__import-output_commands] )) ||
_codex-helm__subcmd__llm__subcmd__help__subcmd__import-output_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm help import-output commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__help__subcmd__preview_commands] )) ||
_codex-helm__subcmd__llm__subcmd__help__subcmd__preview_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm help preview commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__help__subcmd__runs_commands] )) ||
_codex-helm__subcmd__llm__subcmd__help__subcmd__runs_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm help runs commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__help__subcmd__updates_commands] )) ||
_codex-helm__subcmd__llm__subcmd__help__subcmd__updates_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm help updates commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__help__subcmd__validate-output_commands] )) ||
_codex-helm__subcmd__llm__subcmd__help__subcmd__validate-output_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm help validate-output commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__import-output_commands] )) ||
_codex-helm__subcmd__llm__subcmd__import-output_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm import-output commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__preview_commands] )) ||
_codex-helm__subcmd__llm__subcmd__preview_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm preview commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__runs_commands] )) ||
_codex-helm__subcmd__llm__subcmd__runs_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm runs commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__updates_commands] )) ||
_codex-helm__subcmd__llm__subcmd__updates_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm updates commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__llm__subcmd__validate-output_commands] )) ||
_codex-helm__subcmd__llm__subcmd__validate-output_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm llm validate-output commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__presets_commands] )) ||
_codex-helm__subcmd__presets_commands() {
    local commands; commands=(
'list:List available preset/posture decisions' \
'explain:Explain one preset/posture decision set' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm presets commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__presets__subcmd__explain_commands] )) ||
_codex-helm__subcmd__presets__subcmd__explain_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm presets explain commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__presets__subcmd__help_commands] )) ||
_codex-helm__subcmd__presets__subcmd__help_commands() {
    local commands; commands=(
'list:List available preset/posture decisions' \
'explain:Explain one preset/posture decision set' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm presets help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__presets__subcmd__help__subcmd__explain_commands] )) ||
_codex-helm__subcmd__presets__subcmd__help__subcmd__explain_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm presets help explain commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__presets__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__presets__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm presets help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__presets__subcmd__help__subcmd__list_commands] )) ||
_codex-helm__subcmd__presets__subcmd__help__subcmd__list_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm presets help list commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__presets__subcmd__list_commands] )) ||
_codex-helm__subcmd__presets__subcmd__list_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm presets list commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__render_commands] )) ||
_codex-helm__subcmd__render_commands() {
    local commands; commands=(
'clean:Render clean generated TOML' \
'user:Render user-preserving TOML for a CODEX_HOME' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm render commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__render__subcmd__clean_commands] )) ||
_codex-helm__subcmd__render__subcmd__clean_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm render clean commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__render__subcmd__help_commands] )) ||
_codex-helm__subcmd__render__subcmd__help_commands() {
    local commands; commands=(
'clean:Render clean generated TOML' \
'user:Render user-preserving TOML for a CODEX_HOME' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm render help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__render__subcmd__help__subcmd__clean_commands] )) ||
_codex-helm__subcmd__render__subcmd__help__subcmd__clean_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm render help clean commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__render__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__render__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm render help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__render__subcmd__help__subcmd__user_commands] )) ||
_codex-helm__subcmd__render__subcmd__help__subcmd__user_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm render help user commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__render__subcmd__user_commands] )) ||
_codex-helm__subcmd__render__subcmd__user_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm render user commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules_commands] )) ||
_codex-helm__subcmd__rules_commands() {
    local commands; commands=(
'schema:Emit the portable rule-pack JSON Schema' \
'surfaces:List source-backed surface and overlay layer rules' \
'migrations:List data-backed migration rules' \
'conflicts:List data-backed conflict rules' \
'overlays:List overlay ownership/support rules for a surface' \
'presets:List preset evidence for a surface' \
'export:Export a portable local/team rule-pack' \
'import:Import policy records from a portable local/team rule-pack' \
'validate:Validate a portable local/team rule-pack without importing it' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm rules commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__conflicts_commands] )) ||
_codex-helm__subcmd__rules__subcmd__conflicts_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules conflicts commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__export_commands] )) ||
_codex-helm__subcmd__rules__subcmd__export_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules export commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help_commands() {
    local commands; commands=(
'schema:Emit the portable rule-pack JSON Schema' \
'surfaces:List source-backed surface and overlay layer rules' \
'migrations:List data-backed migration rules' \
'conflicts:List data-backed conflict rules' \
'overlays:List overlay ownership/support rules for a surface' \
'presets:List preset evidence for a surface' \
'export:Export a portable local/team rule-pack' \
'import:Import policy records from a portable local/team rule-pack' \
'validate:Validate a portable local/team rule-pack without importing it' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm rules help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__conflicts_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__conflicts_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help conflicts commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__export_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__export_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help export commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__import_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__import_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help import commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__migrations_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__migrations_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help migrations commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__overlays_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__overlays_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help overlays commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__presets_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__presets_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help presets commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__schema_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__schema_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help schema commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__surfaces_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__surfaces_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help surfaces commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__help__subcmd__validate_commands] )) ||
_codex-helm__subcmd__rules__subcmd__help__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules help validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__import_commands] )) ||
_codex-helm__subcmd__rules__subcmd__import_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules import commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__migrations_commands] )) ||
_codex-helm__subcmd__rules__subcmd__migrations_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules migrations commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__overlays_commands] )) ||
_codex-helm__subcmd__rules__subcmd__overlays_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules overlays commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__presets_commands] )) ||
_codex-helm__subcmd__rules__subcmd__presets_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules presets commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__schema_commands] )) ||
_codex-helm__subcmd__rules__subcmd__schema_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules schema commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__surfaces_commands] )) ||
_codex-helm__subcmd__rules__subcmd__surfaces_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules surfaces commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__rules__subcmd__validate_commands] )) ||
_codex-helm__subcmd__rules__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm rules validate commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__snapshot_commands] )) ||
_codex-helm__subcmd__snapshot_commands() {
    local commands; commands=(
'create:Create a snapshot of CODEX_HOME/config.toml' \
'list:List snapshots for a CODEX_HOME' \
'revert:Restore CODEX_HOME/config.toml from a snapshot' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm snapshot commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__snapshot__subcmd__create_commands] )) ||
_codex-helm__subcmd__snapshot__subcmd__create_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm snapshot create commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__snapshot__subcmd__help_commands] )) ||
_codex-helm__subcmd__snapshot__subcmd__help_commands() {
    local commands; commands=(
'create:Create a snapshot of CODEX_HOME/config.toml' \
'list:List snapshots for a CODEX_HOME' \
'revert:Restore CODEX_HOME/config.toml from a snapshot' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm snapshot help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__snapshot__subcmd__help__subcmd__create_commands] )) ||
_codex-helm__subcmd__snapshot__subcmd__help__subcmd__create_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm snapshot help create commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__snapshot__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__snapshot__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm snapshot help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__snapshot__subcmd__help__subcmd__list_commands] )) ||
_codex-helm__subcmd__snapshot__subcmd__help__subcmd__list_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm snapshot help list commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__snapshot__subcmd__help__subcmd__revert_commands] )) ||
_codex-helm__subcmd__snapshot__subcmd__help__subcmd__revert_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm snapshot help revert commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__snapshot__subcmd__list_commands] )) ||
_codex-helm__subcmd__snapshot__subcmd__list_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm snapshot list commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__snapshot__subcmd__revert_commands] )) ||
_codex-helm__subcmd__snapshot__subcmd__revert_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm snapshot revert commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__support_commands] )) ||
_codex-helm__subcmd__support_commands() {
    local commands; commands=(
'bundle:Export a sanitized support bundle' \
'inspect:Review a support bundle before sharing' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm support commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__support__subcmd__bundle_commands] )) ||
_codex-helm__subcmd__support__subcmd__bundle_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm support bundle commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__support__subcmd__help_commands] )) ||
_codex-helm__subcmd__support__subcmd__help_commands() {
    local commands; commands=(
'bundle:Export a sanitized support bundle' \
'inspect:Review a support bundle before sharing' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm support help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__support__subcmd__help__subcmd__bundle_commands] )) ||
_codex-helm__subcmd__support__subcmd__help__subcmd__bundle_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm support help bundle commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__support__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__support__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm support help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__support__subcmd__help__subcmd__inspect_commands] )) ||
_codex-helm__subcmd__support__subcmd__help__subcmd__inspect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm support help inspect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__support__subcmd__inspect_commands] )) ||
_codex-helm__subcmd__support__subcmd__inspect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm support inspect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__tui_commands] )) ||
_codex-helm__subcmd__tui_commands() {
    local commands; commands=(
'preview:Build the current TUI screen model as JSON without starting a terminal' \
'run:Run the guarded terminal UI workflow without applying config writes' \
'apply-effect:Apply a safe TUI effect through the guarded CLI write path' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm tui commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__tui__subcmd__apply-effect_commands] )) ||
_codex-helm__subcmd__tui__subcmd__apply-effect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm tui apply-effect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__tui__subcmd__help_commands] )) ||
_codex-helm__subcmd__tui__subcmd__help_commands() {
    local commands; commands=(
'preview:Build the current TUI screen model as JSON without starting a terminal' \
'run:Run the guarded terminal UI workflow without applying config writes' \
'apply-effect:Apply a safe TUI effect through the guarded CLI write path' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex-helm tui help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__tui__subcmd__help__subcmd__apply-effect_commands] )) ||
_codex-helm__subcmd__tui__subcmd__help__subcmd__apply-effect_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm tui help apply-effect commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__tui__subcmd__help__subcmd__help_commands] )) ||
_codex-helm__subcmd__tui__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm tui help help commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__tui__subcmd__help__subcmd__preview_commands] )) ||
_codex-helm__subcmd__tui__subcmd__help__subcmd__preview_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm tui help preview commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__tui__subcmd__help__subcmd__run_commands] )) ||
_codex-helm__subcmd__tui__subcmd__help__subcmd__run_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm tui help run commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__tui__subcmd__preview_commands] )) ||
_codex-helm__subcmd__tui__subcmd__preview_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm tui preview commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__tui__subcmd__run_commands] )) ||
_codex-helm__subcmd__tui__subcmd__run_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm tui run commands' commands "$@"
}
(( $+functions[_codex-helm__subcmd__validate_commands] )) ||
_codex-helm__subcmd__validate_commands() {
    local commands; commands=()
    _describe -t commands 'codex-helm validate commands' commands "$@"
}

if [ "$funcstack[1]" = "_codex-helm" ]; then
    _codex-helm "$@"
else
    compdef _codex-helm codex-helm
fi
