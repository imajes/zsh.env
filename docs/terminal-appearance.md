# Terminal appearance

Interactive shells select **dayfox** for light terminals and **duskfox** for dark
terminals, and follow changes in an already-open terminal. The suggestion colors
remain index 90 in light mode and index 228 in dark mode. Index 90 is spelled
without a leading zero so Zsh's normalized highlight entries can be removed.

Zsh's startup hook uses rod after Powerlevel10k releases its redirected streams.
While the line editor is active, it subscribes to standard mode-2031 notifications
and consumes the complete `CSI ? 997 ; 1 n` / `CSI ? 997 ; 2 n` reports as widgets.
A report updates shell/delta/grep state and repaints an existing suggestion without
changing the command buffer or cursor. Leaving the editor disables notifications;
entering it requests current state again, covering changes while a command ran.
There is no periodic terminal reader or OS poll.

WezTerm needs portable-env's `terminal-appearance.lua` module loaded with
`require("terminal-appearance").setup()` in its config. It uses palette-change
callbacks and a per-pane opt-in user variable to send the standard reports. This
works through ordinary SSH and a cleared root login environment because the opt-in
travels through the terminal, not an inherited environment variable. Each terminal
keeps its own mode. The adapter checks current opt-in state before sending, and
also refreshes all opted-in inactive tabs when their window palette changes.

For tmux 3.6+, source `~/.config/zsh/libexec/terminal-appearance.tmux` from the
active tmux config. It registers each attached/new client with the WezTerm adapter;
tmux consumes the reports and relays them only to subscribed panes. Hook indexes
make repeated config loads idempotent. Older tmux skips the bridge and needs an
upgrade for live changes. The normal SSH/root pilot still verifies actual deployed
versions; a local fixture does not establish host readiness.

Bash 4.4+ uses Readline bindings for the same reports and PS0 to disable them before
executing a command. It preserves existing PROMPT_COMMAND and PS0 content. Older
Bash retains startup detection. Noninteractive shells, redirected input/output,
and `TERM=dumb` remain quiet.

Install [rod](https://github.com/leiserfg/rod) and Python 3 on each machine, plus
portable-env's `.config/bat` and `.config/rod` files for each account. Build bat's
cache as that account. Delta needs the `nightfox.gitconfig` include. The companion
Ansible role installs these files for selected Linux accounts, including root.

The terminal is the source of the mode. SSH and nested SSH carry its query and
response over the allocated PTY. A new root shell repeats detection against that
same terminal, including a login shell with a cleared environment. No SSH
`SendEnv`/`AcceptEnv` or sudo environment-preservation rule is needed. The target
account must receive the startup hook and its own theme assets/cache.

`libexec/terminal-appearance.py` runs `rod print` with a 1.5-second outer timeout
and restores terminal settings when the process is killed. Rod owns the protocol
parser and has its own timeout. The helper accepts only `light` or `dark`; missing
tools, invalid results and helper timeouts select light. Rod can silently return
its own fallback: install `fallback_to_light = true` in its config for a consistent
fallback. On Linux that is `~/.config/rod/config.toml`; on macOS rod 0.1.13 uses
`~/Library/Application Support/rod/config.toml` (its `dirs` dependency follows the
platform config directory). A returned mode alone does not prove a terminal reply.

The hook exports `LAB_TERMINAL_THEME=light|dark`, updates the legacy
`LIGHT_MODE=LIGHT|DARK` output, grep colors and autosuggestions, and replaces only
Fox entries in `DELTA_FEATURES`. It preserves unrelated delta features and the
leading `+` merge semantics. Bat uses its native `--theme-light`/`--theme-dark`
selection; an explicit existing `BAT_THEME` still takes precedence.

Use `lab_theme_refresh` (or the compatible `update_theme`) for diagnostics or a
manual override; ordinary appearance changes do not require it. `lab_theme_refresh light` and `lab_theme_refresh dark` override the shell
and delta selection without a query. Bat's corresponding explicit previews are
`bat --theme=light` and `bat --theme=dark`. Exact Fox palette recognition remains separate follow-up work.

`libexec/terminal-appearance.bash` supplies the same startup detection and delta
selection for Bash accounts. It preserves scalar or array `PROMPT_COMMAND` and
deduplicates its hooks when login and interactive startup files both source it.

## Validation

```sh
python3 -m unittest discover -s tests -v
REAL_ROD=/absolute/path/to/rod python3 -m unittest discover -s tests -v
shellcheck -s bash libexec/terminal-appearance.bash
zsh -n shell_customizations.d/10-theme.zsh
```

The tests allocate disposable controlling PTYs and temporary homes. They cover
both modes, cleared and stale inherited state, delta feature preservation,
timeouts, invalid output, terminal restoration, prompt-hook behavior and real
upstream rod when supplied, including isolated tmux sessions when installed.
A sandbox must permit terminal ioctls for those tests.
They never invoke sudo or SSH into a real host. Real SSH, `sudo su`, `sudo su -`
and tmux acceptance remains part of the scoped lab pilot.

The live-event regressions cover both transitions, emacs/vi keymaps, typed-buffer
preservation, Readline preservation and notification shutdown. Integration validation
also uses an isolated real WezTerm window and a disposable tmux server, with the
installed syntax-highlighting/autosuggestions plugins, an existing suggestion,
a foreground stdin reader, and the return to an updated prompt.
