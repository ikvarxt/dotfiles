# Rime configuration deployment

`rime/` is a portable Rime source tree, not a GNU Stow package. Do not run
`stow rime`, and do not link the whole `rime/` directory as a user data directory.

For the requested Rime frontend, link each tracked top-level Rime data entry in `rime/`
except `macos/` into its user data directory. Ignore untracked metadata files. Preserve existing regular files and
unrelated symlinks; stop and report a conflict instead of overwriting one.
Keep generated and personal data (`build/`, `sync/`, `*.userdb/`,
`installation.yaml`, `user.yaml`) in the frontend's local user data directory.

Frontend targets:
- Squirrel (macOS): `~/Library/Rime`
- Fcitx5 Rime (Linux): `~/.local/share/fcitx5/rime`
- IBus Rime (Linux): `~/.config/ibus/rime`
- Weasel (Windows): the configured user directory, normally `%APPDATA%\Rime`

On macOS, additionally link `rime/macos/squirrel.custom.yaml` into
`~/Library/Rime`, `rime/macos/bin/*` into `~/.local/bin`, and
`rime/macos/LaunchAgents/*` into `~/Library/LaunchAgents`.
Redeploy with the active frontend after changing links. Verify the compiled
schema and preserve the local user dictionary before considering the job done.
