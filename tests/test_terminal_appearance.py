"""Disposable controlling-TTY tests; no user startup files or sudo required."""
import os
from pathlib import Path
import pty
import re
import select
import shlex
import shutil
import signal
import subprocess
import sys
import tempfile
import time
import unittest

ROOT = Path(__file__).resolve().parents[1]


def shell_path(name):
    return os.environ.get(f"{name.upper()}_TEST_SHELL") or shutil.which(name)


def terminal(argv, env, reply=None, limit=8):
    pid, fd = pty.fork()
    if pid == 0:
        os.execvpe(argv[0], argv, env)
    output = b""
    pending = b""
    deadline = time.monotonic() + limit
    try:
        while time.monotonic() < deadline:
            if not select.select([fd], [], [], 0.1)[0]:
                continue
            try:
                chunk = os.read(fd, 65536)
            except OSError:
                break
            if not chunk:
                break
            output += chunk
            pending += chunk
            if reply:
                # Emulate a terminal in tests only; production uses rod's parser.
                while any(query in pending for query in reply):
                    query = min((q for q in reply if q in pending), key=pending.index)
                    pending = pending[pending.index(query) + len(query):]
                    os.write(fd, reply[query])
        else:
            raise AssertionError(f"PTY command timed out: {output!r}")
    finally:
        os.close(fd)
        ended, status = os.waitpid(pid, os.WNOHANG)
        if not ended:
            os.kill(pid, signal.SIGKILL)
            _, status = os.waitpid(pid, 0)
    return os.waitstatus_to_exitcode(status), output.decode(errors="replace")


class Appearance(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="terminal-appearance-")
        self.addCleanup(self.tmp.cleanup)
        self.home = Path(self.tmp.name)
        bindir = self.home / "bin"
        bindir.mkdir()
        self.log = self.home / "calls"
        rod = bindir / "rod"
        rod.write_text(f"#!{sys.executable}\n" + '''import os, time, tty
with open(os.environ['CALLS'], 'a') as f: f.write('query\\n')
mode = os.environ.get('FAKE_MODE', 'dark')
if mode == 'timeout':
    tty.setraw(0)
    time.sleep(10)
if mode == 'error': raise SystemExit(1)
print(mode)
''')
        rod.chmod(0o755)
        # A clean login-like environment deliberately has no inherited mode.
        self.env = {"HOME": str(self.home), "PATH": f"{bindir}:{os.environ['PATH']}",
                    "TERM": "xterm-256color", "CALLS": str(self.log),
                    "LAB_TERMINAL_TIMEOUT": "0.2", "LC_ALL": "C"}

    def shell(self, shell, body, **env):
        path = shell_path(shell)
        adapter = ROOT / ("shell_customizations.d/10-theme.zsh" if shell == "zsh"
                          else "libexec/terminal-appearance.bash")
        args = [path, "-dfi", "-c"] if shell == "zsh" else [path, "--noprofile", "--norc", "-i", "-c"]
        return terminal(args + [f"source {shlex.quote(str(adapter))}; {body}"], dict(self.env, **env))

    def test_modes_features_and_one_query(self):
        for shell in ("zsh", "bash"):
            for mode, feature in (("light", "dayfox"), ("dark", "duskfox")):
                for configured, expected in (("+side-by-side dawnfox", f"+side-by-side {feature}"),
                                              ("line-numbers duskfox", f"line-numbers {feature}"),
                                              ("", f"+{feature}")):
                    with self.subTest(shell=shell, mode=mode, features=configured):
                        self.log.write_text("")
                        once = 'for hook in $precmd_functions; do "$hook"; done' if shell == "zsh" else '_lab_terminal_startup'
                        body = (f'test ! -s "$CALLS" || exit 5; {once}; {once}; '
                                'printf "RESULT:%s|%s|%s\\n" "$LAB_TERMINAL_THEME" "$LIGHT_MODE" "$DELTA_FEATURES"')
                        rc, out = self.shell(shell, body, FAKE_MODE=mode, LIGHT_MODE="WRONG", DELTA_FEATURES=configured)
                        self.assertEqual(rc, 0, out)
                        self.assertIn(f"RESULT:{mode}|{mode.upper()}|{expected}", out)
                        self.assertEqual(self.log.read_text(), "query\n")

    def test_failure_timeout_restores_tty(self):
        # macOS may set the kernel PENDIN bookkeeping bit when restoring input.
        snapshot = shlex.quote('import termios; a=termios.tcgetattr(0); '
                              'a[3] &= ~getattr(termios,"PENDIN",0); print(a)')
        for mode in ("timeout", "error", "garbage"):
            for shell in ("zsh", "bash"):
                with self.subTest(shell=shell, mode=mode):
                    rc, out = self.shell(shell, f'before=$(python3 -c {snapshot}); _lab_terminal_startup; '
                        f'after=$(python3 -c {snapshot}); [[ $before == "$after" ]] || exit 7; '
                        'printf "RESULT:%s\\n" "$LAB_TERMINAL_THEME"', FAKE_MODE=mode)
                    self.assertEqual(rc, 0, out)
                    self.assertIn("RESULT:light", out)

    def test_manual_refresh_and_existing_bash_prompt(self):
        for shell in ("zsh", "bash"):
            rc, out = self.shell(shell, 'lab_theme_refresh dark; lab_theme_refresh light; '
                'printf "RESULT:%s|%s|%s\\n" "$LAB_TERMINAL_THEME" "$DELTA_FEATURES" "$PROMPT_COMMAND"',
                PROMPT_COMMAND="printf kept", DELTA_FEATURES="+side-by-side")
            self.assertEqual(rc, 0, out)
            self.assertIn("RESULT:light|+side-by-side dayfox|printf kept", out)
            self.assertFalse(self.log.exists())

    def test_dumb_terminal_does_not_query(self):
        for shell in ("zsh", "bash"):
            rc, out = self.shell(shell, '_lab_terminal_startup; printf "RESULT:%s\\n" "${LAB_TERMINAL_THEME-unset}"', TERM="dumb")
            self.assertEqual(rc, 0, out)
            self.assertIn("RESULT:unset", out)
            self.assertFalse(self.log.exists())

    def test_noninteractive_and_redirected_shells_are_quiet(self):
        for shell in ("zsh", "bash"):
            adapter = ROOT / ("shell_customizations.d/10-theme.zsh" if shell == "zsh"
                              else "libexec/terminal-appearance.bash")
            for interactive in (False, True):
                argv = [shell_path(shell)]
                argv += ["-df"] if shell == "zsh" else ["--noprofile", "--norc"]
                if interactive:
                    argv += ["-i"]
                argv += ["-c", f'source {shlex.quote(str(adapter))}; '
                         'if type lab_theme_refresh >/dev/null 2>&1; then lab_theme_refresh; fi; '
                         'printf "RESULT:%s\\n" "${LAB_TERMINAL_THEME-unset}"']
                run = subprocess.run(argv, env=self.env, capture_output=True, text=True, timeout=5)
                self.assertEqual(run.returncode, 0, run.stderr)
                self.assertEqual(run.stdout, "RESULT:unset\n")
                self.assertFalse(self.log.exists())

    def test_hook_registration_is_idempotent(self):
        zsh = shlex.quote(str(ROOT / "shell_customizations.d/10-theme.zsh"))
        rc, out = self.shell("zsh", f'other_hook() {{ :; }}; add-zsh-hook precmd other_hook; '
            f'source {zsh}; source {zsh}; print -r -- "RESULT:${{(j: :)precmd_functions}}"')
        self.assertEqual(rc, 0, out)
        self.assertEqual(out.count("_lab_terminal_startup"), 1)
        self.assertIn("other_hook", out)
        bash = shlex.quote(str(ROOT / "libexec/terminal-appearance.bash"))
        rc, out = self.shell("bash", 'unset _lab_terminal_hook_installed; '
            f'PROMPT_COMMAND=("printf kept" ":"); source {bash}; source {bash}; declare -p PROMPT_COMMAND')
        self.assertEqual(rc, 0, out)
        self.assertIn('declare -a PROMPT_COMMAND=', out)
        self.assertIn('printf kept', out)
        self.assertEqual(out.count("_lab_terminal_startup"), 1)

    def test_first_editable_prompt_after_instant_prompt_redirection(self):
        adapter = shlex.quote(str(ROOT / "shell_customizations.d/10-theme.zsh"))
        for redirected in (False, True):
            for mode, style in (("dark", "fg=228"), ("light", "fg=090")):
                with self.subTest(redirected=redirected, mode=mode):
                    self.log.write_text("")
                    redirect = ('exec {saved_in}<&0 {saved_out}>&1 0</dev/null 1>"$HOME/captured"\n'
                                if redirected else "")
                    restore = ('exec 0<&$saved_in 1>&$saved_out {saved_in}<&- {saved_out}>&-; '
                               if redirected else "")
                    # Powerlevel10k restores streams after earlier precmd hooks.
                    # The assertion runs inside the first real line-init event,
                    # before any command is typed or a second precmd can run.
                    (self.home / ".zshrc").write_text("zmodload zsh/zle\n" + redirect + f"source {adapter}\n" +
                        'restore_prompt() { ' + restore +
                        'add-zsh-hook -d precmd restore_prompt; }\n'
                        'add-zsh-hook precmd restore_prompt\n'
                        'autoload -Uz add-zle-hook-widget\n'
                        'first_line() { '
                        'print -r -- "RESULT:${LAB_TERMINAL_THEME-unset}|$ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE"; '
                        'print -r -- "HOOKS:$precmd_functions"; zstyle -L zle-line-init widgets; exit 0; }\n'
                        'add-zle-hook-widget line-init first_line\nPS1="fixture> "\n')
                    rc, out = terminal([shell_path("zsh"), "-di"],
                                       dict(self.env, ZDOTDIR=str(self.home), FAKE_MODE=mode))
                    self.assertEqual(rc, 0, out)
                    self.assertIn(f"RESULT:{mode}|{style}", out)
                    self.assertNotIn("_lab_terminal_", out)
                    self.assertEqual(self.log.read_text(), "query\n")

    def test_missing_detector_uses_light(self):
        (self.home / "bin/rod").unlink()
        for shell in ("zsh", "bash"):
            rc, out = self.shell(shell, '_lab_terminal_startup; printf "RESULT:%s\\n" "$LAB_TERMINAL_THEME"')
            self.assertEqual(rc, 0, out)
            self.assertIn("RESULT:light", out)

    @unittest.skipUnless(os.environ.get("REAL_ROD"), "set REAL_ROD to test a built upstream detector")
    def test_real_detector(self):
        shutil.copy2(os.environ["REAL_ROD"], self.home / "bin/rod")
        for config in (self.home / ".config/rod", self.home / "Library/Application Support/rod"):
            config.mkdir(parents=True)
            (config / "config.toml").write_text("fallback_to_light = true\n")
        for mode, rgb in (("light", b"ffff/ffff/ffff"), ("dark", b"0000/0000/0000")):
            replies = {b"\x1b]11;?\x1b\\": b"\x1b]11;rgb:" + rgb + b"\x1b\\",
                       b"\x1b]10;?\x1b\\": b"\x1b]10;rgb:8888/8888/8888\x1b\\",
                       b"\x1b]11;?\x07": b"\x1b]11;rgb:" + rgb + b"\x07",
                       b"\x1b]10;?\x07": b"\x1b]10;rgb:8888/8888/8888\x07",
                       b"\x1b[c": b"\x1b[?1;2c", b"\x1b[0c": b"\x1b[?1;2c"}
            rc, out = terminal([sys.executable, str(ROOT / "libexec/terminal-appearance.py")], self.env, replies)
            self.assertEqual(rc, 0, out)
            self.assertTrue(out.rstrip().endswith(mode), repr(out))

    @unittest.skipUnless(os.environ.get("REAL_ROD") and shutil.which("tmux"), "REAL_ROD and tmux required")
    def test_real_detector_through_tmux(self):
        shutil.copy2(os.environ["REAL_ROD"], self.home / "bin/rod")
        for config in (self.home / ".config/rod", self.home / "Library/Application Support/rod"):
            config.mkdir(parents=True)
            (config / "config.toml").write_text("fallback_to_light = true\n")
        socket = str(self.home / "tmux.sock")
        result = self.home / "tmux-mode"
        for mode, rgb in (("light", b"ffff/ffff/ffff"), ("dark", b"0000/0000/0000")):
            replies = {b"\x1b]11;?\x07": b"\x1b]11;rgb:" + rgb + b"\x07",
                       b"\x1b]11;?\x1b\\": b"\x1b]11;rgb:" + rgb + b"\x1b\\",
                       b"\x1b]10;?\x07": b"\x1b]10;rgb:8888/8888/8888\x07",
                       b"\x1b]10;?\x1b\\": b"\x1b]10;rgb:8888/8888/8888\x1b\\",
                       b"\x1b[c": b"\x1b[?1;2c", b"\x1b[0c": b"\x1b[?1;2c",
                       b"\x1b[>c": b"\x1b[>0;136;0c"}
            command = "sleep 0.3; " + shlex.join([sys.executable, str(ROOT / "libexec/terminal-appearance.py")])
            command += " > " + shlex.quote(str(result))
            try:
                rc, out = terminal([shutil.which("tmux"), "-S", socket, "-f", "/dev/null",
                                    "new-session", "-s", "appearance", command], self.env, replies)
                self.assertEqual(rc, 0, out[-1000:])
                self.assertEqual(result.read_text().strip(), mode)
            finally:
                subprocess.run([shutil.which("tmux"), "-S", socket, "kill-server"], env=self.env,
                               stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


if __name__ == "__main__":
    unittest.main()
