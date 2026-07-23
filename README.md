# My dotfiles

Using Stow to store all of my dot configuration files in this repository.

## Rime / Squirrel

The `rime` Stow package installs the tracked Squirrel configuration, backup
commands, and LaunchAgents:

```sh
stow --restow -d ~/dotfiles -t ~ rime
```

The live LevelDB under `~/Library/Rime/*.userdb/` is never committed. A daily
job asks Squirrel to create a consistent text snapshot, encrypts changed
snapshots with `age`, and stores the ciphertext in `rime-data/`. A weekly job
commits and pushes only when the rest of the dotfiles worktree is clean.

Manual commands:

```sh
rime-backup
rime-backup --push
rime-restore
```

The age identity is stored outside this repository at:

```text
~/Library/Application Support/rime-backup/age-key.txt
```

Keep a second copy of that identity in a password manager. Without it,
`rime-data/luna_pinyin.userdb.txt.age` cannot be restored.
