"""Helpers resolve external executables without recursing through themselves."""
from support import ShellTestCase


class CommandDiscoveryTests(ShellTestCase):
    def binary(self, name, output):
        path = self.home / "tools" / name
        path.parent.mkdir(exist_ok=True)
        path.write_text('#!/bin/sh\nprintf "%s\\n" "' + output + '" "$@"\n')
        path.chmod(0o700)
        return path

    def invoke(self, extra):
        # Empty fixture satisfies the existing readability check; no real auth
        # file, restore helper or service is used by these command-resolution tests.
        secret = self.home / ".config/msgvault/client_secret.json"
        secret.parent.mkdir(parents=True)
        secret.write_text("{}\n")
        return self.shell('fpath=("$ZDOTDIR/functions" $fpath); autoload -Uz msgvault; '
                          'msgvault "two words"', extra)

    def test_msgvault_uses_the_external_path_entry(self):
        binary = self.binary("msgvault", "FROM_PATH")
        self.assertEqual(self.invoke({"PATH": str(binary.parent) + ":/usr/bin:/bin"}),
                         "FROM_PATH\ntwo words\n")

    def test_msgvault_preserves_explicit_binary_override(self):
        binary = self.binary("custom-msgvault", "OVERRIDE")
        self.assertEqual(self.invoke({"MSGVAULT_BIN": str(binary)}), "OVERRIDE\ntwo words\n")

    def test_missing_msgvault_fails_without_running_restore(self):
        actual = self.shell('path=(); fpath=("$ZDOTDIR/functions" $fpath); '
                            'autoload -Uz msgvault; msgvault 2> "$HOME/error"; '
                            'print -r -- $?')
        self.assertEqual(actual.strip(), "127")
        self.assertIn("msgvault binary not found", (self.home / "error").read_text())
