# My dotfiles

Using Stow to store all of my dot configuration files in this repository.

## zsh

```sh
stow --restow -d ~/dotfiles -t ~ zsh
```

Replaces oh-my-zsh. `~/.zshrc` itself is **not** tracked: it is a real file
holding this machine's PATH, work aliases, and credentials, and it pulls in the
portable half with one line:

```sh
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/init.zsh"
```

`init.zsh` sources the modules in a load-bearing order — `core` before `git`
(which needs `compdef`) and before `tools` (`bindkey -e` re-links the main
keymap, which would drop fzf's bindings):

| module | contents |
| --- | --- |
| `core.zsh` | `compinit`, `$EDITOR`, `bindkey -e`, history, grep/history aliases |
| `directories.zsh` | vendored from oh-my-zsh `lib/directories.zsh` |
| `git.zsh` | vendored from the oh-my-zsh `git` plugin, plus `git_current_branch` |
| `aliases.zsh` | portable personal aliases |
| `tools.zsh` | starship, mise, fzf — each guarded by an existence check |

The two vendored files are kept close to verbatim so upstream diffs stay
reviewable.

On a new machine, write a fresh `~/.zshrc` with the source line above; nothing
in this package assumes anything about the host.

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
- Candidate operations: the physical number row `1`–`9` selects candidates in
  order even though Programmer Dvorak normally produces symbols there;
  `Tab`/`Shift+Tab` moves through candidates, `Control+,`/`Control+.`
  selects the first/last character, and `Control+Delete` forgets a learned
  candidate.

Personal fixed phrases go in
`~/Library/Rime/custom_phrase_double.txt` as
`phrase<Tab>code<Tab>weight`. Never store secrets there.

The vendored Rime Ice source revision and license are recorded in
`rime/Library/Rime/rime_ice_vendor/SOURCE.md`. After changing configuration,
redeploy from the menu or run:

```sh
"/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel" --reload
```
