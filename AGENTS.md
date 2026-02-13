This repo is a personal dotfiles collection managed with GNU Stow.

## Directory structure

```
dotfiles/
├── stow/                    # Stow packages (mirror $HOME structure)
│   ├── nvim/.config/nvim/   # Neovim configuration
│   ├── tmux/.config/tmux/   # Tmux configuration
│   ├── zsh/.zshrc           # Zsh configuration
│   ├── git/                 # Git config
│   ├── karabiner/           # Karabiner-Elements (keyboard remapping)
│   ├── btop/                # Btop system monitor
│   └── _deprecated/         # Legacy configs (alacritty)
├── scripts/                 # Helper scripts
├── fonts/                   # Font files
├── docs/                    # Historical docs and notes
├── .claude/docs/            # Domain-specific documentation
└── install.sh               # Installation script (interactive)
```

## Install script

```bash
./install.sh           # Interactive mode
./install.sh --check   # Show status of all packages
./install.sh --all     # Install everything
```

The script manages:
- Homebrew formulas: stow, neovim, tmux, ripgrep, fd, fzf, bat, zoxide, fnm
- Homebrew casks: ghostty, font-agave-nerd-font, karabiner-elements
- Stow packages: nvim, tmux, zsh, git, karabiner

## Common operations

- Link a package: `cd stow && stow <package> -t ~`
- Neovim entry point: `stow/nvim/.config/nvim/init.lua`
- Zsh config: `stow/zsh/.zshrc`
- Tmux config: `stow/tmux/.config/tmux/tmux.conf`

## Domain documentation

See `.claude/docs/` for detailed configs:
- `neovim.md` - Keymaps, plugins, LSP servers
- `tmux.md` - Prefix key, pane navigation
- `karabiner.md` - Keyboard remapping rules

## Safety notes

- Avoid committing secrets
- Karabiner `automatic_backups/` are generated; don't edit
- `_deprecated/` contains legacy configs kept for reference
