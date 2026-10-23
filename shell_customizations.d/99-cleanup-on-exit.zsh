# Optional cleanup for explicitly registered background jobs owned by this shell.
# Usage: command &; register_project_cleanup $!
# Register individual child PIDs; names, groups, sockets and daemonized jobs are
# deliberately outside this API. A service should remove its own socket.
autoload -Uz add-zsh-hook
zmodload zsh/parameter || return 0
typeset -gA _project_cleanup_jobs _project_cleanup_commands

_project_cleanup_find_job() {
  emulate -L zsh
  local pid=$1 job
  [[ $pid == <-> ]] && (( pid > 1 && pid != $$ )) || return 1
  for job in ${(k)jobstates}; do
    if [[ ":${jobstates[$job]}:" == *":${pid}=running:"* ||
          ":${jobstates[$job]}:" == *":${pid}=suspended:"* ]]; then
      REPLY=$job
      return 0
    fi
  done
  return 1
}

register_project_cleanup() {
  emulate -L zsh
  local pid=$1 REPLY
  if (( $# != 1 )) || ! _project_cleanup_find_job "$pid"; then
    print -ru2 -- 'Usage: register_project_cleanup <PID of a running background job owned by this shell>'
    return 2
  fi
  _project_cleanup_jobs[$pid]=$REPLY
  _project_cleanup_commands[$pid]=${jobtexts[$REPLY]}
  add-zsh-hook zshexit _project_cleanup_exec
}

_project_cleanup_exec() {
  emulate -L zsh
  local pid REPLY
  for pid in ${(k)_project_cleanup_jobs}; do
    # Check current job ownership again; never signal a PID that left our jobs.
    if _project_cleanup_find_job "$pid" &&
       [[ $REPLY == ${_project_cleanup_jobs[$pid]} &&
          ${jobtexts[$REPLY]} == ${_project_cleanup_commands[$pid]} ]]; then
      builtin kill -TERM -- "$pid" 2>/dev/null
    fi
    unset "_project_cleanup_jobs[$pid]" "_project_cleanup_commands[$pid]"
  done
  return 0
}
