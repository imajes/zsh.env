# Zsh configuration

This repository owns the shell configuration under `$HOME/.config/zsh`.
`$HOME/.zshenv` must arrange for this `.zshenv` to be read; it sets `ZDOTDIR`.
Mise configuration belongs to the separate home-dotfiles repository. A change to
this repository alone does not install or change language toolchains.

## Startup order and ownership

1. `.zshenv` establishes paths; `.zprofile` performs login integration and base
   PATH ordering after macOS `path_helper`.
2. `.zshrc` selects portable policy, loads Powerlevel10k configuration once,
   prepares executable discovery and function/completion paths, then initializes Zim.
3. The remaining `shell_customizations.d/*.zsh` files load in lexical order.
   Fresh mise activation follows static path additions and owns project runtime
   transitions. There is no cached activation script or automatic PATH pin hook.
4. The existing private `$HOME/.env_local` loads last. `20-auth.zsh` still loads
   `$HOME/.op/plugins.sh` when present. These credential boundaries are unchanged;
   further design work is deferred pending the owner’s requirements.

`01-path.zsh` removes empty, relative, dot and bare-HOME PATH entries, deduplicates
and places personal bins and Homebrew before system binaries. Mise and active
virtual environments can take precedence for their tools. Other inherited
application paths remain available. Manual PATH helper functions are retained;
explicit pins are not enabled by startup.

## Generated state

Completions generated from installed mise and codex-helm binaries live in
`${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions`, ahead of source completions.
The generator cache validates syntax and publishes atomically; a failed refresh
keeps a prior valid cache. The compinit dump is in the parent cache directory.
Source functions are never compiled during startup.

Startup does not invoke `op`, including for completion generation: the installed
CLI initializes its daemon/config even for that command. An existing cached or
installed `_op` file remains usable through compinit. A fresh lab without that
file has no op-specific completion; generating one is explicit maintenance in an
appropriate environment, outside the credential-isolated lab.

Compiled `.zwc` and `.zwc.old` files, session timestamps, history and Zim runtime
state are ignored. Untracking preserves local files. The owner separately
approved removal of the obsolete `functions/_mise.zwc.old`; its protected lab
snapshot remains. The existing `functions/_mise` source and its local edits are
retained for owner review; generated completion takes priority. Duplicate stale
codex-helm completion files and the unused source-compilation helper are removed.
The pinned `.zim/zimfw.zsh` bootstrap remains intentionally versioned.

## Interactive behavior

See [CHEATSHEET.md](CHEATSHEET.md) for navigation, history and editor commands.
Shared Zsh history has one persistence policy. Atuin owns Ctrl-R when installed;
substring search owns Up/Down. vi/vim wrappers retain their editor preference and
pause; EOF cancels the pause. Keychain agent startup requires
`ZSH_KEYCHAIN_ENABLE=1`; it is unrelated to macOS Keychain.

SSH, Docker and `CI=true`/`CI=1` select portable policy before modules initialize.
Gitstatus is disabled and syntax-highlighting/autosuggestion modules are skipped.
OSC7 uses encoded URLs, supported interactive terminals only, and
`OSC7_DISABLE=1` as an opt-out.

[Terminal appearance](docs/terminal-appearance.md) is selected once at the first
interactive prompt through rod: dayfox for light terminals, duskfox for dark.
The attached terminal supplies the mode through SSH and new root shells. The
shell exports the legacy `LIGHT_MODE` result, updates grep/autosuggestions and
selects delta's matching native feature. Bat and Neovim use their own terminal
detection. The companion portable-env assets and detector installation are
required; live switching and the real remote pilot are separate follow-up work.

`register_project_cleanup PID` accepts only a job owned by this shell and sends
TERM to that registered PID at exit. It never kills by process name or removes
service sockets. [mark_run](libexec/README.md) provides separate command logging
and timeout supervision, requires Python 3, and omits arguments from logs.

## Review and maintenance

Use a fresh disposable shell for changes to startup, completions or hooks. Do not
source the full `.zshrc` into an established working terminal. The companion
homelab `environments/zsh-lab` provides disposable HOME/XDG paths, blocked network,
write/read/signal containment checks, actual installed runtimes and Apple/Homebrew
Zsh tests. It excludes private configuration and live history by design, so those
integrations need a separately authorized canary after review.

Keep changes on isolated branches until accepted. Stage exact source files,
commit one logical change at a time with conventional messages, and commit lab
regressions separately. Live promotion should back up individual reviewed files,
check for source drift, retain a recovery `zsh -f` terminal, and test fresh shells.
Never replace the entire configuration directory or copy lab histories/caches.

For existing installed Zim modules, `zimfw build` rebuilds initialization after
module declarations change. Installing/updating/removing modules is a separate
maintenance operation that may access the network. Startup’s existing bootstrap
behavior for a missing framework remains; the isolated lab includes the installed
framework and does not validate a fresh network installation.

The stale reminder measures the core file's age; it does not check releases or
module freshness. `zimfw check-version` checks the core release and `zimfw upgrade`
upgrades it. `zimfw check` checks modules and `zimfw update` updates them. Qualify
core and module upgrades separately in the lab after cleanup validation, before
applying them to the active shell.
