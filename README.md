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

The active schema is `小鹤双拼・Programmer Dvorak`. It uses a pinned subset of
Rime Ice for the Chinese and English dictionaries while continuing to learn
into `luna_pinyin.userdb`, so the existing encrypted backup remains valid.

Useful input:

- Mixed Chinese/English: type the English word directly, such as `github`.
- Date/time: `date`, `time`, `week`, `datetime`, `timestamp`, `datezh`, `dateen`.
- Lunar calendar: `N` plus a date, for example `N20260723`.
- Calculator: `cC` plus an expression, for example `cC1+2*3`.
- Unicode: `U` plus a hexadecimal code point, for example `U4e2d`.
- Number/RMB conversion: `R` plus a number.
- UUID: `uuid`.
- Candidate operations: `Tab`/`Shift+Tab` move through candidates,
  `[`/`]` select the first/last character, and `Control+Delete` forgets a
  learned candidate.

Personal fixed phrases go in
`~/Library/Rime/custom_phrase_double.txt` as
`phrase<Tab>code<Tab>weight`. Never store secrets there.

The vendored Rime Ice source revision and license are recorded in
`rime/Library/Rime/rime_ice_vendor/SOURCE.md`. After changing configuration,
redeploy from the menu or run:

```sh
"/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel" --reload
```
