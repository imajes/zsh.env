#!/usr/bin/env python3
"""Bound rod's query and restore terminal settings after interruption.

Protocol parsing belongs to rod/terminal-colorsaurus. A rod result may itself
be its configured fallback; it is not proof that the terminal answered.
"""
import argparse
import os
import shutil
import subprocess
import termios


def detect(timeout):
    rod = shutil.which("rod")
    if not rod or os.environ.get("TERM", "dumb") == "dumb":
        return "light"
    tty_fd = None
    previous = None
    try:
        tty_fd = os.open("/dev/tty", os.O_RDWR | os.O_NOCTTY)
        previous = termios.tcgetattr(tty_fd)
        result = subprocess.run(
            [rod, "print"], stdin=tty_fd, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True, timeout=timeout, check=False,
        )
        mode = result.stdout.strip().lower()
        return mode if result.returncode == 0 and mode in ("light", "dark") else "light"
    except (OSError, UnicodeError, subprocess.TimeoutExpired, termios.error):
        return "light"
    finally:
        if tty_fd is not None:
            try:
                if previous is not None:
                    termios.tcsetattr(tty_fd, termios.TCSANOW, previous)
            except (OSError, termios.error):
                # The terminal may have disconnected while the query ran.
                pass
            finally:
                os.close(tty_fd)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--timeout", type=float, default=1.5)
    args = parser.parse_args()
    if not 0.05 <= args.timeout <= 5:
        parser.error("timeout must be between 0.05 and 5 seconds")
    print(detect(args.timeout))


if __name__ == "__main__":
    main()
