if-shell -F '#{>=:#{version},3.6}' {
# tmux 3.6+: WezTerm reports the current theme to each attached client.
# tmux relays it only to panes that have enabled standard mode 2031.
set-hook -g client-attached[2031] { run-shell 'printf "\033]1337;SetUserVar=LAB_TERMINAL_NOTIFY=dG11eA==\007" > #{q:client_tty}' }
set-hook -g client-detached[2031] { run-shell 'printf "\033]1337;SetUserVar=LAB_TERMINAL_NOTIFY=MA==\007" > #{q:client_tty}' }

set-hook -g after-new-session[2031] { run-shell 'printf "\033]1337;SetUserVar=LAB_TERMINAL_NOTIFY=dG11eA==\007" > #{q:client_tty}' }
}
