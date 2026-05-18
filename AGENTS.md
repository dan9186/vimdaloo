# Agent Instructions

## Overview

Vimdaloo is a personal Vim configuration that turns Vim into a full IDE-like environment. It is designed to be cloned directly to `~/.vim` and provides a curated set of plugins, keybindings, and language-specific settings.

## Tech Stack

- **Vim** (primary target; not Neovim)
- **Vimscript** — all configuration lives in `vimrc`
- **Bash** — `run.sh` handles install, setup, and submodule updates
- **Pathogen** — plugin manager (`autoload/pathogen.vim`)
- **Git submodules** — all plugins live under `bundle/` as submodules

## Build & Validate

Initial install (clone + setup):
```sh
git clone --recursive https://github.com/dan9186/vimdaloo.git $HOME/.vim
$HOME/.vim/run.sh
```

Update all submodules:
```sh
$HOME/.vim/run.sh update
```

`run.sh` installs OS prereqs (brew/yum), builds YouCompleteMe with all completers, archives any existing `~/.vimrc`, and symlinks `~/.vim/vimrc` → `~/.vimrc`.

## Repository Layout

| Path | Purpose |
|---|---|
| `vimrc` | Main Vim configuration — all settings and keybindings |
| `run.sh` | Install and update script |
| `bundle/` | All plugins as git submodules |
| `autoload/` | Pathogen plugin loader |
| `templates/` | New-file templates (`.go`, `.feature`, `.travis.yml`, etc.) |
| `spell/` | Custom spell-check word list (`en.utf-8.add`) |
| `backup/` | Vim backup files (kept out of working dirs) |
| `swap/` | Vim swap files (kept out of working dirs) |
| `fonts/` | Powerline-compatible fonts for airline |

## Architecture Notes

- Plugins are loaded exclusively via Pathogen — never install plugins manually or via another package manager.
- Adding a plugin means adding a git submodule under `bundle/` and configuring it in `vimrc`.
- Removing a plugin means deleting the submodule entry and any corresponding `vimrc` config.
- YouCompleteMe requires a post-install build step (`install.py`) run by `run.sh`; it is not usable from a plain submodule checkout.
- `~/.vimrc` is a symlink to `~/.vim/vimrc` — edit `vimrc` in this repo, not `~/.vimrc`.

## Key Conventions

- All plugin configuration goes in `vimrc`, grouped under a comment matching the plugin name.
- Use tabs (width 3) for indentation by default; per-filetype overrides are already defined in `vimrc` — add new ones there.
- Keybindings: split navigation uses `Ctrl+hjkl`; NERDTree toggle is `Ctrl+n`; Copilot accept is `Ctrl+j`.
- Never commit files from `backup/` or `swap/` — both are `.gitignore`d.
- After adding or removing a submodule, commit both `.gitmodules` and the updated `bundle/` index entry together.
- `run.sh update` updates all submodule HEADs but does not commit — commit manually to preserve the pinned state.
