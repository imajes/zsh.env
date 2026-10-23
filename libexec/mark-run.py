#!/usr/bin/env python3
"""Log command outcomes without arguments; supervise only our new process group."""
import argparse
import math
import os
import shutil
import signal
import subprocess
import sys
import time
import uuid


def positive_seconds(value):
    number = float(value)
    if not math.isfinite(number) or number <= 0:
        raise argparse.ArgumentTypeError('timeout must be a positive finite number')
    return number


def main():
    parser = argparse.ArgumentParser(description=__doc__, usage='mark_run [-t seconds] CATEGORY -- command [args...]')
    parser.add_argument('-t', '--timeout', type=positive_seconds)
    parser.add_argument('category')
    parser.add_argument('command', nargs=argparse.REMAINDER)
    args = parser.parse_args()
    if args.command[:1] == ['--']:
        args.command.pop(0)
    if not args.command:
        parser.error('an external command is required')
    run_id = str(uuid.uuid4())
    logger = shutil.which('osmark')
    subsystem = os.environ.get('MARK_LOG_SUBSYSTEM', 'mn.foxes.mark')

    def log(event, level='default', **fields):
        # No executable, arguments, environment values, or command output.
        message = f'[mark_log] {event} run_id={run_id}'
        message += ''.join(f' {key}={value}' for key, value in fields.items())
        if logger:
            try:
                subprocess.run([logger, '--subsystem', subsystem, '--category', args.category,
                                '--level', level, '--', message], timeout=2, check=False,
                               stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            except (OSError, subprocess.TimeoutExpired):
                pass  # Logging failure must never change the command result.

    interrupted = 0

    def on_signal(signum, _frame):
        nonlocal interrupted
        interrupted = interrupted or signum

    for signum in (signal.SIGINT, signal.SIGTERM, signal.SIGHUP):
        signal.signal(signum, on_signal)
    log('START')
    started = time.monotonic()
    try:
        child = subprocess.Popen(args.command, start_new_session=True)
    except OSError as exc:
        status = 127 if isinstance(exc, FileNotFoundError) else 126
        print('mark_run: command could not be started', file=sys.stderr)
        log('END', status=status, duration='0.000s', timed_out=0)
        return status

    def signal_group(signum):
        try:
            os.killpg(child.pid, signum)
        except ProcessLookupError:
            pass

    timed_out = False
    while child.poll() is None:
        if interrupted:
            break
        if args.timeout is not None and time.monotonic() - started >= args.timeout:
            timed_out = True
            break
        time.sleep(0.02)
    if timed_out or interrupted:
        # A separate session prevents signals from reaching the caller or its jobs.
        signal_group(signal.SIGTERM if timed_out else interrupted)
        if timed_out:
            log('TIMEOUT', level='error', after=f'{args.timeout:g}s')
        deadline = time.monotonic() + 2
        while time.monotonic() < deadline:
            child.poll()  # Reap a finished leader before checking its group.
            try:
                os.killpg(child.pid, 0)
            except ProcessLookupError:
                break
            time.sleep(0.02)
        # Also catch descendants that outlived a leader which handled TERM.
        signal_group(signal.SIGKILL)
    result = child.wait()
    status = 124 if timed_out else (128 + interrupted if interrupted else
                                   result if result >= 0 else 128 - result)
    log('END', status=status, duration=f'{time.monotonic()-started:.3f}s', timed_out=int(timed_out))
    return status


if __name__ == '__main__':
    raise SystemExit(main())
