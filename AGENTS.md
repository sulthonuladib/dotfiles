# AGENTS.md

Personal dotfiles for an Arch/Omarchy (Hyprland) machine, with a secondary Ubuntu/Ansible install path. There is no build, test, or lint step — changes are config files that take effect on reload.

## Layout → install target

Managed by **GNU stow** (not copies). Repo root is the stow dir; each top-level package's *contents* map to `$HOME` (the package name is stripped):

| Package (contents) | Installs to | Method |
| --- | --- | --- |
| `<app>/.config/<app>/` | `~/.config/<app>` | stow — `nvim`, `fish`, `git`, `ghostty`, `omarchy`, `tmux` |
| `shell/` (`.zshrc`, `.zshenv`) | `~` | stow |
| `bin/.local/bin/` | `~/.local/bin` | stow |
| `tasks/`, `setup.yml` | — | Ansible |
| `.ssh/` | `~/.ssh` | Ansible (see secret note) |

- Editing `~/.config/<app>` edits the repo directly (it's a symlink). There is no re-copy step.
- Shell is **fish** (`fish/.config/fish/`), not zsh. `shell/.zshrc` is legacy/secondary. `conf.d/*.fish` files auto-load.
- `tmux-old/` and `wezterm/` exist as packages but are **not** in the default stow list — add them to `packages` in `install-configs.sh` if wanted.

## Commands

- `./install-configs.sh` — stows the default package list into `$HOME`. Flags: `--restow` (refresh links after moving files), `--delete` (unstow). Run from anywhere.
- `ansible-playbook setup.yml --ask-become-pass --ask-vault-pass` — Ubuntu path; currently only installs the SSH key. Requires the **vault password**. (There is no Makefile; run the playbook directly.)
- `./install-arch.sh` — Arch package installs (includes `stow`).

## Secret

`.ssh/id_ed25519` is **Ansible Vault encrypted** (`$ANSIBLE_VAULT;1.1;AES256`). Never commit a decrypted copy. Installing it requires the vault password via `setup.yml` (`ansible-playbook setup.yml --ask-become-pass --ask-vault-pass`).

## Neovim (`nvim/.config/nvim`)

- Uses Neovim's built-in **`vim.pack`** package manager, not lazy.nvim. Plugins are declared in `lua/sulthonuladib/pack.lua`; lockfile is `nvim-pack-lock.json`.
- Load order is deliberate (comments in `pack.lua` / `pack-hooks.lua`): `pack-hooks.lua` must require before `vim.pack.add`; `vim.g.base46_cache` is set in `core/init.lua` before plugins; **mason must load before lspconfig**.
- Adding an LSP server means editing **both** `plugins/lsp/lspconfig.lua` (`vim.lsp.enable`) and `plugins/lsp/mason.lua` (`ensure_installed`).
- Lua is formatted with **stylua** (`conform.lua` maps `lua → stylua`; `.stylua.toml` is present but empty). Format on save is off by default — use `<leader>f`.

## Omarchy

`omarchy/.config/omarchy/` overrides `~/.config/omarchy` on an Omarchy install. Files under `hooks/<event>.d/` run on their event (e.g. `post-update.d/`). `OMARCHY_PATH=/usr/share/omarchy` is set in fish. Runtime state (e.g. `plugins/flux/`) is tracked here too, so writes through the `~/.config/omarchy` symlink land in the repo. Custom bar widgets in `shell.json` are QML modules under `bar/modules/` (e.g. `net-speed`).

## Style notes

- `fish/.config/fish/fish_variables` is machine-local: fish rewrites it, so it's **gitignored** (see `.gitignore`). Don't re-add it.
- Several fish files hardcode `/home/sulthonuladib/...` (pnpm, `GHIDRA_INSTALL_DIR`). Prefer `$HOME` when editing.
- Default git branch is `master` (`git/.config/git/config`); this repo's branch is `master`.
