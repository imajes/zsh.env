"""Focused shell contracts; no plugins, credentials or network are loaded.

Run: ZSH_TEST_SHELL=/bin/zsh python3 -m unittest discover -s tests -v
"""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

SOURCE = Path(__file__).resolve().parents[1]
SHELL = os.environ.get("ZSH_TEST_SHELL", shutil.which("zsh") or "/bin/zsh")


class ShellTestCase(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="zsh-policy-")
        self.addCleanup(self.temp.cleanup)
        self.home = Path(self.temp.name)
        self.env = {"HOME": str(self.home), "ZDOTDIR": str(SOURCE),
                    "PATH": "/usr/bin:/bin", "TERM": "xterm-256color"}

    def shell(self, code, extra=None):
        result = subprocess.run([SHELL, "-dfc", code], cwd=self.home,
                                env=self.env | (extra or {}), capture_output=True,
                                text=True, timeout=15)
        self.assertEqual(result.returncode, 0, result.stderr + result.stdout)
        self.assertEqual(result.stderr, "")
        return result.stdout

    def mode(self, extra=None):
        return self.shell('source "$ZDOTDIR/shell_customizations.d/03-terminal.zsh"; '
                          'print -r -- "$ZSH_PORTABLE_MODE"', extra).strip()
