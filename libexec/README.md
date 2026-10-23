# Command outcome logging

`mark_run [-t SECONDS] CATEGORY -- command [args...]` logs START/END metadata
through osmark when available. It never logs expanded arguments, environment,
or output. Python 3 supervises a separate process group; timeouts return 124,
normal failures retain their status, and signals return 128 + signal. Timeout or
interruption sends a signal to owned descendants, then KILL after two seconds.
A descendant that deliberately starts another session is outside that group.

The command must be an external executable; for shell syntax/functions, use an
explicit shell command (for example `mark_run build -- zsh -c '…'`). Input/output
are inherited, but full-screen interactive/job-control programs are outside this
batch-command helper’s contract. Missing/failing osmark does not change status.
