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
- Tweak via `~/.p10k.zsh`.

**prompt-pwd**

- Shortened current directory display.

## 3. Completion

**zsh-completions**

- Community-maintained completions for many CLI tools.
- Installed to `${ZDOTDIR}/src`.

**completion**

- Zim's built-in completion manager.

**fzf** & **fzf-tab**

- `fzf` invokes fuzzy finder.
- `<Tab>` cycles candidates in context.

  - Use `<Ctrl-R>` to search history.

## 4. macOS-Specific

**brew** plugin

- Auto-suggest `brew install <formula>` when command not found.

**zsh-lux**

- `macos_is_dark` function for light/dark theme detection.

**noreallyjustfuckingstopalready**

- `flushdns`/`resetdns` helpers.

**macos** utilities

- `open`, `mdfind`, and other OS X helpers.

**keychain**

- Integrates with macOS Keychain via `security`.

## 5. Sysadmin & Secrets

**utility**

- Aliases: `mcd`, `extract`, etc.

**exa/eza**

- Enhanced `ls` replacement: `exa -h --icons --group-directories-first`.

**1password-op**

- `op` CLI: `op signin`, `op read`, `op item get`.

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

- Desktop notification when long-running commands finish.

## 9. Final Init (Order Matters)

- **direnv** ― `direnv allow`/`direnv deny` per-directory env.
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
- `setopt INC_APPEND_HISTORY`, `SHARE_HISTORY`, `EXTENDED_HISTORY`, plus hygiene flags.

### Editor Wrappers

- `vi`/`vim` redirect to preferred `$EDITOR` (`nvim` > `vim` > `vi`), with pause prompt.

### Atuin Integration

- `atuin init zsh` for searchable, remote-synced history.

### Dev Environment Variables

- `RUBY_YJIT_ENABLE=1`, `DISABLE_SPRING=true`, `OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES`, `JAVA_HOME` on macOS.

### Directory Navigation

- `zoxide` (`z <pattern>`), plus `setopt AUTO_CD`, `AUTO_PUSHD`, stack helpers `b`, `dgo`, `alias d='dirs -v'`.

### Portable/CI Mode

- On SSH or Docker: disable gitstatus, highlights, autosuggestions for performance.

### Cleanup Hooks

- `register_project_cleanup <proc> <socket>` to kill processes & remove sockets on exit.

---

**Save this as `CHEATSHEET.md` in your dotfiles repo and refer to it whenever you add or update modules.**
