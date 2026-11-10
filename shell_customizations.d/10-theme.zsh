# Follow the attached terminal once the interactive prompt owns its real TTY.
[[ -o interactive ]] || return 0

typeset -g _lab_terminal_helper=${${(%):-%x}:A:h:h}/libexec/terminal-appearance.py

lab_theme_refresh() {
  emulate -L zsh
  local mode=${1:-auto} prefix='' feature
  local -a features retained
  [[ -t 0 && -t 1 && -n $TERM && $TERM != dumb ]] || return 0

  case $mode in
    light|dark) ;;
    auto)
      mode=light
      if (( $+commands[python3] )); then
        mode=$(command python3 "$_lab_terminal_helper" --timeout "${LAB_TERMINAL_TIMEOUT:-1.5}") || mode=light
      fi
      [[ $mode == (light|dark) ]] || mode=light
      ;;
    *) print -u2 'usage: lab_theme_refresh [auto|light|dark]'; return 2 ;;
  esac

  export LAB_TERMINAL_THEME=$mode LIGHT_MODE=${mode:u}
  if [[ $mode == dark ]]; then
    export GREP_COLORS='sl=49;38;5;247;2:cx=49;38;5;242;2:mt=48;5;197;38;5;222;1;4:fn=49;38;5;199;2:ln=49;38;5;199;2:bn=49;38;5;141;2:se=49;38;5;81;1'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=228'
  else
    export GREP_COLORS='sl=49;38;5;242;2:cx=49;38;5;247;2:mt=48;5;222;38;5;197;1;4:fn=49;38;5;199;2:ln=49;38;5;199;2:bn=49;38;5;141;2:se=49;38;5;81;1'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=090'
  fi

  # Retain delta's config additions/replacement semantics and unrelated features.
  local configured=${DELTA_FEATURES-}
  [[ -z $configured || $configured == +* ]] && prefix=+
  configured=${configured#+}
  features=(${=configured})
  for feature in $features; do
    [[ $feature == (dayfox|dawnfox|duskfox|nightfox|nordfox|terafox|carbonfox) ]] || retained+=($feature)
  done
  [[ $mode == dark ]] && retained+=(duskfox) || retained+=(dayfox)
  export DELTA_FEATURES="${prefix}${(j: :)retained}"
}

# Retain the old manual command without retaining per-prompt OS polling.
update_theme() { lab_theme_refresh "$@"; }

_lab_terminal_startup() {
  [[ -t 0 && -t 1 ]] || return 0
  lab_theme_refresh
  add-zsh-hook -d precmd _lab_terminal_startup
  add-zle-hook-widget -d line-init _lab_terminal_line_init
}

# ZLE widgets receive /dev/null on stdin; rod still queries the controlling TTY.
_lab_terminal_line_init() { _lab_terminal_startup </dev/tty; }

# Instant prompt can still own redirected streams during precmd. Retry at the
# first editable prompt, after the prompt renderer restores the terminal.
zmodload zsh/zle
autoload -Uz add-zsh-hook add-zle-hook-widget
add-zsh-hook -d precmd update_theme
add-zsh-hook -d precmd _lab_terminal_startup
add-zsh-hook precmd _lab_terminal_startup
add-zle-hook-widget -d line-init _lab_terminal_line_init
add-zle-hook-widget line-init _lab_terminal_line_init
