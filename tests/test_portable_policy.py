"""Portable account defaults and session overrides."""
from support import ShellTestCase


class PortablePolicyTests(ShellTestCase):
    def test_explicit_on_without_ssh(self):
        self.assertEqual(self.mode({"ZSH_PORTABLE_MODE": "1"}), "1")

    def test_explicit_off_over_ssh(self):
        self.assertEqual(self.mode({"ZSH_PORTABLE_MODE": "0", "SSH_CONNECTION": "fixture"}), "0")

    def test_automatic_ssh_and_ci(self):
        for env in ({"SSH_CONNECTION": "fixture"}, {"CI": "true"}, {"CI": "1"}):
            with self.subTest(env=env):
                self.assertEqual(self.mode(env), "1")

    def test_account_policy_and_explicit_override(self):
        (self.home / ".zsh_portable-env").write_text(': ${ZSH_PORTABLE_MODE:=1}\n')
        self.assertEqual(self.mode(), "1")
        self.assertEqual(self.mode({"ZSH_PORTABLE_MODE": "0"}), "0")

    def test_policy_survives_prompt_configuration(self):
        (self.home / ".zsh_portable-env").write_text(': ${ZSH_PORTABLE_MODE:=1}\n')
        actual = self.shell('source "$ZDOTDIR/shell_customizations.d/03-terminal.zsh"; '
                            'source "$ZDOTDIR/.p10k.zsh"; '
                            'print -r -- "$POWERLEVEL9K_DISABLE_GITSTATUS"')
        self.assertEqual(actual.strip(), "true")

    def test_invalid_mode_does_not_evaluate_arithmetic(self):
        self.mode({"ZSH_PORTABLE_MODE": 'x[$(touch BAD)]', "SSH_CONNECTION": "fixture"})
        self.assertFalse((self.home / "BAD").exists())
