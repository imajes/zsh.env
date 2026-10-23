# Portable mode was selected before prompt and plugin initialization.
autoload -Uz portable:osc7_cwd add-zsh-hook
add-zsh-hook -d precmd portable:osc7_cwd
add-zsh-hook -d chpwd portable:osc7_cwd
if (( ZSH_PORTABLE_MODE )); then
  add-zsh-hook precmd portable:osc7_cwd
  add-zsh-hook chpwd portable:osc7_cwd
fi
