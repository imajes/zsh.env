# Terminal appearance

Interactive shells select **dayfox** for light terminals and **duskfox** for dark
terminals. `10-theme.zsh` registers one-shot `precmd` and `line-init` hooks. If
Powerlevel10k still redirects the terminal during `precmd`, detection retries
when the first editable prompt starts. The first successful initialization removes
both hooks. Existing prompt and line-editor hooks are preserved. Noninteractive shells, redirected input/output
and `TERM=dumb` do not query the terminal.

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

Use `lab_theme_refresh` (or the compatible `update_theme`) to re-query an existing
shell. `lab_theme_refresh light` and `lab_theme_refresh dark` override the shell
and delta selection without a query. Bat's corresponding explicit previews are
`bat --theme=light` and `bat --theme=dark`. Automatic continuous switching and
exact Fox palette recognition are separate follow-up work.

`libexec/terminal-appearance.bash` supplies the same startup detection and delta
selection for Bash accounts. It preserves scalar or array `PROMPT_COMMAND` and
runs once even when both login and interactive startup files source it.

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
