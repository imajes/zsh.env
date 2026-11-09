"""Executable discovery and platform-specific shell behavior."""
from support import ShellTestCase
from pathlib import Path


class PathPolicyTests(ShellTestCase):
    def test_macos_homebrew_precedes_inherited_system_paths(self):
        actual = self.shell('OSTYPE=darwin25; '
                            'source "$ZDOTDIR/shell_customizations.d/01-path.zsh"; '
                            'print -rl -- "${path[@]}"').splitlines()
        expected = [p for p in ("/opt/homebrew/bin", "/opt/homebrew/sbin") if Path(p).is_dir()]
        self.assertEqual(actual, expected + ["/usr/bin", "/bin"])

    def test_linux_path_precedence_and_absent_directories(self):
        dirs = ["bin", ".codex/bin", ".local/bin", ".atuin/bin", ".yarn/bin",
                ".config/yarn/global/node_modules/.bin", ".cargo/bin", ".acme.sh", "src/go/bin"]
        for rel in dirs:
            (self.home / rel).mkdir(parents=True)
        actual = self.shell('OSTYPE=linux-gnu; '
                            'source "$ZDOTDIR/shell_customizations.d/01-path.zsh"; '
                            'print -rl -- "${path[@]}"').splitlines()
        self.assertEqual(actual, [str(self.home / p) for p in dirs] + ["/usr/bin", "/bin"])
        (self.home / ".yarn/bin").rmdir()
        actual = self.shell('OSTYPE=linux-gnu; '
                            'source "$ZDOTDIR/shell_customizations.d/01-path.zsh"; '
                            'print -rl -- "${path[@]}"').splitlines()
        self.assertNotIn(str(self.home / ".yarn/bin"), actual)

    def test_unsafe_path_entries_and_duplicates(self):
        alias = self.home / "home-alias"
        alias.symlink_to(self.home, target_is_directory=True)
        incoming = f":.:relative:{self.home}/:{alias}:/usr/bin:/bin:/usr/bin"
        actual = self.shell('OSTYPE=linux-gnu; '
                            'source "$ZDOTDIR/shell_customizations.d/01-path.zsh"; '
                            'print -rl -- "${path[@]}"', {"PATH": incoming}).splitlines()
        self.assertEqual(actual, ["/usr/bin", "/bin"])

    def test_literal_paths_and_repeat_initialization(self):
        (self.home / "bin").mkdir()
        extra = self.home / "app [a]* space/bin"
        extra.mkdir(parents=True)
        actual = self.shell('source "$ZDOTDIR/shell_customizations.d/01-path.zsh"; '
                            'before=$PATH; source "$ZDOTDIR/shell_customizations.d/01-path.zsh"; '
                            '[[ $before == $PATH ]] || exit 91; print -rl -- "${path[@]}"',
                            {"PATH": str(extra) + ":/usr/bin:/bin"}).splitlines()
        self.assertEqual(actual.count(str(extra)), 1)

    def test_colon_home_does_not_generate_split_entries(self):
        home = self.home / "colon:home"
        (home / "bin").mkdir(parents=True)
        actual = self.shell('OSTYPE=linux-gnu; '
                            'source "$ZDOTDIR/shell_customizations.d/01-path.zsh"; '
                            'print -rl -- "${path[@]}"', {"HOME": str(home)}).splitlines()
        self.assertEqual(actual, ["/usr/bin", "/bin"])

    def test_xdg_yarn_and_custom_gopath(self):
        config = self.home / "custom config"
        yarn = config / "yarn/global/node_modules/.bin"
        roots = [self.home / "go one", self.home / "go two"]
        for p in [yarn, *(p / "bin" for p in roots)]:
            p.mkdir(parents=True)
        actual = self.shell('OSTYPE=linux-gnu; '
                            'source "$ZDOTDIR/shell_customizations.d/01-path.zsh"; '
                            'print -rl -- "${path[@]}"',
                            {"XDG_CONFIG_HOME": str(config), "GOPATH": ":".join(map(str, roots))}).splitlines()
        self.assertEqual(actual, list(map(str, [yarn, *(p / "bin" for p in roots)])) + ["/usr/bin", "/bin"])

    def test_platform_ls_fallback(self):
        # No optional commands are discoverable. Core is sourced explicitly so
        # aliases are inspected without invoking ls or loading the whole shell.
        for ostype, expected in [("linux-gnu", "ls --color=auto"), ("darwin25", "ls -G")]:
            actual = self.shell('path=(); OSTYPE=$TEST_OS; '
                                'source "$ZDOTDIR/shell_customizations.d/02-core.zsh"; '
                                'print -r -- "$aliases[ls]"', {"TEST_OS": ostype})
            self.assertEqual(actual.strip(), expected)
