# Follow the attached terminal at startup and while the line editor is active.
[[ -o interactive ]] || return 0

typeset -g _lab_terminal_initialized=0
typeset -g _lab_terminal_helper=${${(%):-%x}:A:h:h}/libexec/terminal-appearance.py

lab_theme_refresh() {
  emulate -L zsh
  local mode=${1:-auto}
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

  _lab_terminal_apply "$mode"
  _lab_terminal_initialized=1
}

_lab_terminal_apply() {
  emulate -L zsh
  local mode=$1 prefix='' feature
  local -a features retained
  [[ $mode == (light|dark) ]] || return 2
  export LAB_TERMINAL_THEME=$mode LIGHT_MODE=${mode:u}
  if [[ $mode == dark ]]; then
    export GREP_COLORS='sl=49;38;5;247;2:cx=49;38;5;242;2:mt=48;5;197;38;5;222;1;4:fn=49;38;5;199;2:ln=49;38;5;199;2:bn=49;38;5;141;2:se=49;38;5;81;1'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=228'
  else
    export GREP_COLORS='sl=49;38;5;242;2:cx=49;38;5;247;2:mt=48;5;222;38;5;197;1;4:fn=49;38;5;199;2:ln=49;38;5;199;2:bn=49;38;5;141;2:se=49;38;5;81;1'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=90'
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
  [[ -t 0 && -t 1 && $TERM != dumb ]] || return 0
  lab_theme_refresh
  add-zsh-hook -d precmd _lab_terminal_startup
}

# These are complete, standard mode-2031 reports. ZLE consumes them as key
# sequences; no second process reads terminal input or competes with typed text.
_lab_terminal_notify_dark() { _lab_terminal_notification dark; }
_lab_terminal_notify_light() { _lab_terminal_notification light; }
_lab_terminal_notification() {
  _lab_terminal_apply "$1"
  # Repaint a suggestion already on screen, without accepting or discarding it.
  if (( $+functions[_zsh_autosuggest_highlight_reset] )); then
    _zsh_autosuggest_highlight_reset
    _zsh_autosuggest_highlight_apply
  fi
  zle -R
}

_lab_terminal_line_init() {
  [[ -t 1 && $TERM != dumb ]] || return 0
  # ZLE widgets have /dev/null on stdin. Initial rod detection needs the TTY.
  if (( ! _lab_terminal_initialized )); then
    _lab_terminal_startup </dev/tty
  fi
  # Supporting terminals (including tmux 3.6+) report later theme changes.
  # Query again on entry: a foreground application may have changed the mode.
  print -rn -- $'\e[?2031h\e[?996n'
  if [[ -z $TMUX ]]; then
    # WezTerm's Lua adapter supplies the same report on palette changes.
    # Other terminals ignore this iTerm2 user variable. No environment forwarding
    # is required across SSH or a cleared root login environment.
    print -rn -- $'\e]1337;SetUserVar=LAB_TERMINAL_NOTIFY=MQ==\a'
  fi
}

_lab_terminal_line_finish() {
  [[ -t 1 && $TERM != dumb ]] || return 0
  print -rn -- $'\e[?2031l'
  [[ -n $TMUX ]] || print -rn -- $'\e]1337;SetUserVar=LAB_TERMINAL_NOTIFY=MA==\a'
}

zmodload zsh/zle
autoload -Uz add-zsh-hook add-zle-hook-widget
zle -N _lab_terminal_notify_dark
zle -N _lab_terminal_notify_light
# Underscore-prefixed widgets are excluded by zsh-autosuggestions.
for _lab_terminal_keymap in emacs viins vicmd; do
  bindkey -M "$_lab_terminal_keymap" $'\e[?997;1n' _lab_terminal_notify_dark
  bindkey -M "$_lab_terminal_keymap" $'\e[?997;2n' _lab_terminal_notify_light
done
unset _lab_terminal_keymap
add-zsh-hook -d precmd update_theme
add-zsh-hook -d precmd _lab_terminal_startup
add-zsh-hook precmd _lab_terminal_startup
add-zsh-hook -d zshexit _lab_terminal_line_finish
add-zsh-hook zshexit _lab_terminal_line_finish
add-zle-hook-widget -d line-init _lab_terminal_line_init
add-zle-hook-widget line-init _lab_terminal_line_init
add-zle-hook-widget -d line-finish _lab_terminal_line_finish
add-zle-hook-widget line-finish _lab_terminal_line_finish
