# ---------------------------------------------------------------
# Project‐specific exit cleanup infrastructure

# Ensure we have add-zsh-hook available
autoload -Uz add-zsh-hook

# The workhorse: kills a process and removes its socket
function _project_cleanup_exec() {
  local proc=$1 sock=$2

  if pgrep -x "$proc" &>/dev/null; then
    print -P "%F{yellow}⏹ Stopping $proc...%f"
    pkill -x "$proc"
  fi
  if [[ -S $sock ]]; then
    print -P "%F{yellow}🗑 Removing stale socket: $sock%f"
    rm -f "$sock"
  fi
}

# Public API: call this with a process name and a socket path
function register_project_cleanup() {
  local proc=$1 sock=$2

  if [[ -z $proc || -z $sock ]]; then
    echo "Usage: register_project_cleanup <proc_name> <socket_path>"
    return 1
  fi

  # Hook _project_cleanup_exec on shell EXIT
  add-zsh-hook EXIT "_project_cleanup_exec '$proc' '$sock'"
}
