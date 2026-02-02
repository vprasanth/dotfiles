This repo is a personal dotfiles collection managed with GNU Stow.

Scope and layout
- Stow packages live under `stow/<name>` and mirror `$HOME` (e.g. `stow/nvim/.config/nvim`).
- Top-level helpers: `install.sh`, `apps.txt`, `scripts/`, `starship.toml`, `default.env.zsh`.
- Backups under `stow/karabiner/.config/karabiner/automatic_backups` are generated; avoid editing them.

Common operations
- Link a package into `$HOME`: `stow <package> -t ~`
- Neovim config entry point: `stow/nvim/.config/nvim/init.lua`
- Zsh aliases: `stow/zsh/aliases.sh`
- Tmux config: `stow/tmux/.config/tmux/tmux.conf`
- Terminal configs: `stow/kitty/.config/kitty/kitty.conf`, `stow/alacritty/.config/alacritty/alacritty.toml`

Safety and hygiene
- Avoid committing secrets (e.g. `default.env.zsh` contains an API key placeholder).
- Prefer editing source files under `stow/` rather than generated lockfiles or backups.
