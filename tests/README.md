# Shell regression checks

These focused checks use Python's standard library and Zsh with startup files
disabled. Each test gets temporary HOME state; plugins, credentials and network
services are not loaded. Linux policy branches can be checked on macOS, but that
does not establish native Linux/plugin behavior.

From this repository:

```sh
ZSH_TEST_SHELL=/bin/zsh python3 -m unittest discover -s tests -v
ZSH_TEST_SHELL=/opt/homebrew/bin/zsh python3 -m unittest discover -s tests -v
```

Use an installed Zsh path on Linux. The Homebrew command is optional on macOS.

## Portable policy

`~/.zsh_portable-env`, when readable, is sourced before Powerlevel10k and Zim.
It is a trusted shell configuration file, like `.zshrc`. Account defaults should
preserve explicit overrides, for example `: ${ZSH_PORTABLE_MODE:=1}`.

`ZSH_PORTABLE_MODE` accepts `0` (full prompt/plugins), `1` (lightweight portable
mode), or `auto` (SSH/container/CI detection). Unset or unrecognized values use
automatic detection. A portable account may supply its own default. To recompute
automatic detection while reloading configuration, set the value to `auto` first.

The policy tests cover account defaults, both explicit overrides, automatic SSH
and CI selection, safe handling of invalid values, and Powerlevel10k reloads.

## Executable discovery

Existing user tool directories precede system paths. In order: `~/bin`,
`~/.codex/bin`, `~/.local/bin`, Atuin, Yarn, global Yarn packages, Cargo proxies,
acme.sh, and each GOPATH bin directory. macOS then adds installed Apple Silicon
Homebrew directories. Absolute inherited application/system paths follow.
GOPATH defaults to `~/src/go`; existing GOPATH and XDG_CONFIG_HOME are respected.
Mise activates after these static additions and owns project runtime transitions.

Empty/relative entries and aliases of bare HOME are removed. Missing user tool
directories and paths containing a colon are not added. PATH keeps exact directory
names containing spaces or glob characters, and repeated initialization deduplicates
entries. The platform fallback for `ls` uses BSD or GNU options as appropriate.
The `msgvault` wrapper discovers its external binary through PATH and retains
`MSGVAULT_BIN` overrides; its existing credential/restore behavior is unchanged.

## Quick manual check after candidate installation

In a fresh candidate shell, run:

```zsh
print -r -- "HOME=$HOME" "ZDOTDIR=$ZDOTDIR" "portable=$ZSH_PORTABLE_MODE"
print -rl -- $path
whence -a git mise ruby node python3 cargo atuin
```

Confirm the expected account and tools. Enter and leave a project with a mise
version override, then open a nested shell; runtime selection should follow the
project and PATH should stay free of duplicates or bare HOME. Exercise Tab,
Ctrl-R and Up/Down history. Launch with `ZSH_PORTABLE_MODE=0 zsh` and
`ZSH_PORTABLE_MODE=1 zsh` to check both policy choices.
