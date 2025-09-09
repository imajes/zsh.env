# # shell_customizations.d/99-welcome.zsh - interactive shell banner
#
# # Skip if not interactive or if user disabled
# [[ -o interactive ]] || return
# [[ "$DISABLE_ZSH_WELCOME" == 1 ]] && return
#
# # Show welcome info once per session
# if [[ -z "$ZSH_WELCOME_SHOWN" ]]; then
#   ZSH_WELCOME_SHOWN=1
#   ~/bin/zsh-welcome
# fi
