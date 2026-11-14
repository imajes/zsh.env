# Bash adapter for accounts whose interactive shell is Bash (including root).
[[ $- == *i* ]] || return 0
_lab_terminal_helper="$(builtin cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/terminal-appearance.py"

lab_theme_refresh() {
  local mode=${1:-auto} configured=${DELTA_FEATURES-} prefix='' feature
  local -a features retained=()
  [[ -t 0 && -t 1 && -n ${TERM-} && $TERM != dumb ]] || return 0
  case $mode in
    light|dark) ;;
    auto)
      mode=light
      if command -v python3 >/dev/null; then
        mode=$(command python3 "$_lab_terminal_helper" --timeout "${LAB_TERMINAL_TIMEOUT:-1.5}") || mode=light
      fi
      [[ $mode == light || $mode == dark ]] || mode=light
      ;;
    *) printf '%s\n' 'usage: lab_theme_refresh [auto|light|dark]' >&2; return 2 ;;
  esac
  export LAB_TERMINAL_THEME=$mode
  if [[ $mode == dark ]]; then
    export LIGHT_MODE=DARK
  else
    export LIGHT_MODE=LIGHT
  fi
  [[ -z $configured || $configured == +* ]] && prefix=+
  configured=${configured#+}
  read -r -a features <<< "$configured"
  for feature in "${features[@]}"; do
    case $feature in
      dayfox|dawnfox|duskfox|nightfox|nordfox|terafox|carbonfox) ;;
      *) retained+=("$feature") ;;
    esac
  done
  [[ $mode == dark ]] && retained+=(duskfox) || retained+=(dayfox)
  export DELTA_FEATURES="${prefix}${retained[*]}"
}

_lab_terminal_startup() {
  [[ -t 0 && -t 1 && ${TERM-} != dumb ]] || return 0
  if [[ ${_lab_terminal_started-} != 1 ]]; then
    lab_theme_refresh
    _lab_terminal_started=1
  fi
  if [[ ${_lab_terminal_readline_events-} == 1 ]]; then
    printf '\033[?2031h\033[?996n'
    [[ -n ${TMUX-} ]] || printf '\033]1337;SetUserVar=LAB_TERMINAL_NOTIFY=MQ==\007'
  fi
}

# Preserve scalar and array PROMPT_COMMAND, and avoid duplicate hooks.
if [[ ${_lab_terminal_hook_installed-} != 1 ]]; then
  if [[ $(declare -p PROMPT_COMMAND 2>/dev/null) == 'declare -a '* ]]; then
    PROMPT_COMMAND+=(_lab_terminal_startup)
  else
    # This branch handles the scalar form; the array branch above preserves arrays.
    # shellcheck disable=SC2178,SC2128
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }_lab_terminal_startup"
  fi
  _lab_terminal_hook_installed=1
fi

# Bash 4.4+ provides PS0, emitted after Readline accepts a command and before
# execution. It gives notifications the same prompt-only lifetime as Zsh's ZLE.
if (( BASH_VERSINFO[0] > 4 || (BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] >= 4) )) &&
   [[ ${_lab_terminal_readline_events-} != 1 && -t 0 && -t 1 && ${TERM-} != dumb ]]; then
  _lab_terminal_notify_dark() { lab_theme_refresh dark; }
  _lab_terminal_notify_light() { lab_theme_refresh light; }
  bind -x '"\e[?997;1n":_lab_terminal_notify_dark'
  bind -x '"\e[?997;2n":_lab_terminal_notify_light'
  _lab_terminal_stop=$'\e[?2031l'
  [[ -n ${TMUX-} ]] || _lab_terminal_stop+=$'\e]1337;SetUserVar=LAB_TERMINAL_NOTIFY=MA==\a'
  PS0="${_lab_terminal_stop}${PS0-}"
  unset _lab_terminal_stop
  _lab_terminal_readline_events=1
fi
