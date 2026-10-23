**Zsh Configuration Cheat Sheet**

> A consolidated list of plugins, tools, and key commands/features from your Zim/Zsh setup.

---

## 1. Core UX Modules

**input** ― Expanded keybindings and behaviors:

- `<Tab>` completes via Zsh's built-in.
- `..` expands to `../` for directory traversal.

**termtitle** ― Automatic terminal title updates:

- Title set to `%n@%m: %~` (or `␥ %n@%m: %~` when SSH).

## 2. Prompt

**powerlevel10k** (`romkatv/powerlevel10k`)

- Fast, customizable prompt with git status and command duration.
- Tweak via `$ZDOTDIR/.p10k.zsh`.

**prompt-pwd**

- Shortened current directory display.

## 3. Completion

**zsh-completions**

- Community-maintained completions for many CLI tools.
- Installed under `$ZDOTDIR/.zim/modules/zsh-completions/src`.

**completion**

- Zim's built-in completion manager.

**fzf** & **fzf-tab**

- `fzf` invokes fuzzy finder.
- `<Tab>` cycles candidates in context.

  - Use `<Ctrl-R>` to search history.

## 4. macOS-Specific

**brew** plugin

- Auto-suggest `brew install <formula>` when command not found.

**noreallyjustfuckingstopalready**

- `flushdns`/`resetdns` helpers.

**macos** utilities

- `open`, `mdfind`, and other OS X helpers.

**keychain**

- SSH/GPG agent manager; enabled only with `ZSH_KEYCHAIN_ENABLE=1` before startup.
- This plugin is unrelated to macOS Keychain and its `security` command.

## 5. Sysadmin & Secrets

**utility**

- Aliases: `mcd`, `extract`, etc.

**exa/eza**

- Enhanced `ls` replacement: `exa -h --icons --group-directories-first`.

**1Password CLI**

- Native `op` CLI; its completion script is generated in the dedicated cache.
- No recursive wrapper or credential lookup runs during completion setup.

**sysadmin-util**

- `rebootlog`, `portwatch`, etc.

## 6. DevOps & Tooling

**mise**

- Version manager: `mise use <version>`, `mise install`.

**rake-completion**

- Tab-complete `rake` tasks.

**Ansible**

- `ansible`, `ansible-playbook` completions.

**AWS CLI**

- `aws`, `aws configure`, `aws s3 sync` completions.

**Azure CLI**

- `az`, `az login`, `az group list` completions.

**Helm**

- `helm install`, `helm repo add` completions.

**Terraform**

- `terraform init`, `terraform apply` completions.

**kubectl**

- `kubectl get pods`, `kubectl describe svc` completions.

## 7. Git & GitHub

**forgit**

- `gtd` (git tree show), `gca`, `gd` with fzf integration.

## 8. UX Add-Ons

**history-search-multi-word**

- Incremental search: type multiple words to filter history.

**zsh-auto-notify**

- Desktop notification when long-running commands finish; the default title omits command arguments.

## 9. Final Init (Order Matters)

- **zsh-syntax-highlighting** ― Real-time syntax colors.
- **zsh-history-substring-search** ― `↑`/`↓` through history substrings.
- **zsh-autosuggestions** ― Inline suggestions; accept with `<→>`.

---

## Shell Customizations (Manual Settings)

### Extended Globbing & Safety

- `setopt EXTENDED_GLOB`, `NO_CLOBBER`, `NO_HUP`, `INTERACTIVE_COMMENTS`.

### Aliases & PATH

- `alias ls='eza ...'` / fallback `ls -G`.
- `alias rg='rg -p -M 200 ...'`, `alias ss='sudo su -'`, `alias la='ls -la'`.

### History Settings

- `HISTSIZE=200000`, `SAVEHIST=200000`.
- `SHARE_HISTORY` writes and imports shared history; competing incremental modes are disabled. `EXTENDED_HISTORY` and hygiene flags remain.

### Editor Wrappers

- `vi`/`vim` redirect to preferred `$EDITOR` (`nvim` > `vim` > `vi`), with pause prompt.

### Atuin Integration

- Ctrl-R uses Atuin when installed; otherwise Zim multi-word search remains available. Up/Down and Ctrl-P/Ctrl-N use substring search. Re-sourcing history configuration does not reinitialize Atuin.

- Atuin provides searchable history; synchronization and privacy depend on its own configuration.

### Dev Environment Variables

- Ruby performance preferences remain enabled; mise owns Java and `JAVA_HOME`.
- Fork-safety exceptions and Neovim Ruby debug logging are not enabled globally.
- Pry uses its normal history configuration rather than a project-relative override.

### Directory Navigation

- `zoxide` (`z <pattern>`), plus `setopt AUTO_CD`, `AUTO_PUSHD`, stack helpers `b`, `dgo`, `alias d='dirs -v'`.

### Portable/CI Mode

- On SSH, Docker, or `CI=true`/`CI=1`: select policy before initialization, disable gitstatus, and skip syntax-highlighting/autosuggestion modules.
- Powerlevel10k configuration loads once. Theme updates use a deduplicated hook and preserve other `precmd` functions.
- Portable OSC7 reports percent-encoded directory URLs only to supported interactive terminals; `OSC7_DISABLE=1` opts out.

### Cleanup Hooks

- `command &; register_project_cleanup $!` to send TERM to that shell-owned job on exit. Register individual child PIDs; services own their socket cleanup.

---

See [README.md](README.md) for startup/cache ownership, isolated validation, and maintenance boundaries.

`path:watch-start`, `path:watch-status`, `path:watch-stop` observe changes without redispatching mise or other hooks. `files-from` supports native macOS find and raw filename output with `-0`; `ctime` means inode change time. `mark_run` logs metadata only; see [its contract](libexec/README.md).

The commented credential experiment in `20-secrets.zsh` remains dormant and untouched with the deferred credential work.
