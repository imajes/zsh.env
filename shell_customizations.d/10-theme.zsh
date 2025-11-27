# $ZDOTDIR/shell_customizations.d/10-theme.zsh - dark/light detection & colours

# Resolve LIGHT_MODE from the environment when provided (e.g. forwarded over SSH),
# otherwise use macOS AppleInterfaceStyle where available, else default to LIGHT.
update_theme() {
  local mode="${LIGHT_MODE:-}"

  if [[ -z $mode ]]; then
    if [[ $(uname) == Darwin ]] && command -v defaults >/dev/null 2>&1; then
      local style
      if style=$(defaults read -g AppleInterfaceStyle 2>/dev/null); then
        [[ ${style:l} == dark ]] && mode='DARK' || mode='LIGHT'
      else
        mode='LIGHT'
      fi
    else
      mode='LIGHT'
    fi
  fi

  if [[ ${mode:u} == DARK ]]; then
    export LIGHT_MODE='DARK'
    export BAT_THEME='Visual Studio Dark+'
    export GREP_COLORS='sl=49;38;5;247;2:cx=49;38;5;242;2:mt=48;5;197;38;5;222;1;4:fn=49;38;5;199;2:ln=49;38;5;199;2:bn=49;38;5;141;2:se=49;38;5;81;1'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=228'
  else
    export LIGHT_MODE='LIGHT'
    export BAT_THEME='Coldark-Cold'
    export GREP_COLORS='sl=49;38;5;242;2:cx=49;38;5;247;2:mt=48;5;222;38;5;197;1;4:fn=49;38;5;199;2:ln=49;38;5;199;2:bn=49;38;5;141;2:se=49;38;5;81;1'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=090'
  fi
}

# macOS: run on every prompt so theme tracks system appearance;
# on other hosts, run once at startup using the current LIGHT_MODE.
[[ $(uname) == Darwin ]] && precmd() { update_theme }
update_theme

# Load Powerlevel10k prompt (after theme vars)
[[ -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] && source ${ZDOTDIR:-$HOME}/.p10k.zsh

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
