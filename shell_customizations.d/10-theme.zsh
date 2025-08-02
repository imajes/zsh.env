# $ZDOTDIR/shell_customizations.d/10-theme.zsh - dark/light detection & colours

# Use caller-provided macos_is_dark() if present; otherwise fallback to LIGHT.
update_theme() {
  dark_override=false

  dark=0
  if $dark_override; then
    dark=1
  elif typeset -f macos_is_dark >/dev/null && macos_is_dark; then
    dark=1
  fi

  if (( dark )); then
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

# macOS: run on every prompt; elsewhere rely on LIGHT_MODE or your own hook
[[ $(uname) == Darwin ]] && precmd() { update_theme }
: "${LIGHT_MODE:=LIGHT}"

# Load Powerlevel10k prompt (after theme vars)
[[ -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] && source ${ZDOTDIR:-$HOME}/.p10k.zsh

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
