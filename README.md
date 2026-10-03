# My dotfiles

Using Stow for most dot configuration files. Rime has a shared source tree
that is linked into each platform's Rime user directory.

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
| `smart-suggestion.zsh` | Ctrl-O LLM completion, loaded only when its build is installed |

The two vendored files are kept close to verbatim so upstream diffs stay
reviewable.

`smart-suggestion.zsh` needs zsh-autosuggestions, a binary built by
`smart-suggestion/install.sh` (upstream plus `deepseek-provider.patch`, needs Go),
and magpie running, whose local gateway serves the model:

```sh
brew install zsh-autosuggestions
~/dotfiles/smart-suggestion/install.sh
```

On a new machine, write a fresh `~/.zshrc` with the source line above; nothing
in this package assumes anything about the host.

## Rime / Squirrel

The `rime/` directory contains the Rime configuration files at their native
relative paths. It is not a Stow package. An agent links each tracked top-level Rime
data entry except `macos/` into the frontend's user directory:

| Frontend | User directory |
| --- | --- |
| Squirrel (macOS) | `~/Library/Rime` |
| Fcitx5 Rime (Linux) | `~/.local/share/fcitx5/rime` |
| IBus Rime (Linux) | `~/.config/ibus/rime` |
| Weasel (Windows) | `%APPDATA%\Rime` by default |

On macOS, also link `rime/macos/squirrel.custom.yaml` into `~/Library/Rime`,
`rime/macos/bin/*` into `~/.local/bin`, and `rime/macos/LaunchAgents/*` into
`~/Library/LaunchAgents`. Keep the user directory itself real: `build/`,
`sync/`, `*.userdb/`, `installation.yaml`, and `user.yaml` are local runtime
data. Do not replace an existing regular file while creating links.

The live LevelDB under `~/Library/Rime/*.userdb/` is never committed. A daily
job asks Squirrel to create a consistent text snapshot, encrypts changed
snapshots with `age`, and stores the ciphertext in `rime-data/`. A weekly job
commits and pushes only the encrypted snapshot when the rest of the dotfiles
worktree is clean.

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

The active schema is `小鹤双拼・Dvorak` using the standard macOS Dvorak layout.
It uses a pinned subset of Rime Ice for the Chinese and English dictionaries
while continuing to learn into `luna_pinyin.userdb`, so the existing encrypted
backup remains valid.

Useful input:

- Mixed Chinese/English: type the English word directly, such as `github`.
- Date/time: `date`, `time`, `week`, `datetime`, `timestamp`, `datezh`, `dateen`.
- Lunar calendar: `N` plus a date, for example `N20260723`.
- Calculator: `cC` plus an expression, for example `cC1+2*3`.
- Unicode: `U` plus a hexadecimal code point, for example `U4e2d`.
- Number/RMB conversion: `R` plus a number.
- UUID: `uuid`.
- Candidate operations: the standard Dvorak number row `1`–`9` selects
  candidates directly. `Control+N`/`Control+P` moves through candidates and
  can cross pages. `Tab`/`Shift+Tab` moves through the composition,
  `Control+,`/`Control+.` selects the first/last character, and
  `Control+Delete` forgets a learned candidate.
- Direct punctuation in Chinese mode: `[` and `]` output `【` and `】` rather
  than paging; `{` and `}` output literal braces, and `*` outputs `……`.

Personal fixed phrases go in
`~/Library/Rime/custom_phrase_double.txt` as
`phrase<Tab>code<Tab>weight`. Never store secrets there.

The vendored Rime Ice source revision and license are recorded in
`rime/rime_ice_vendor/SOURCE.md`. After changing configuration,
redeploy from the menu or run:

```sh
"/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel" --reload
```
