# Neovim Configuration

## File structure

```
stow/nvim/.config/nvim/
├── init.lua          # Entry point: bootstrap lazy.nvim, set leader keys, load modules
├── lua/
│   ├── plugins.lua   # All plugin specs (lazy.nvim format)
│   ├── opts.lua      # Editor options (timeoutlen, search, whitespace, etc.)
│   ├── keys.lua      # Global keymaps (buffer, window management)
│   ├── vars.lua      # Global variables
│   └── config/       # Plugin-specific configurations
│       ├── lsp.lua       # LSP setup (Mason, server configs, keymaps)
│       ├── cmp.lua       # Completion configuration
│       ├── diagnostics.lua
│       └── telescope.lua
```

## Key settings

- **Leader key**: `,` (comma) - set in `init.lua:66`
- **Local leader**: `\` (backslash)
- **Timeout**: 500ms (`opts.lua:30`) - time to complete key sequences
- **Plugin manager**: lazy.nvim with lazy-loading by default

## Keymap groups (leader prefixes)

| Prefix | Group | Examples |
|--------|-------|----------|
| `<leader>f` | Find (Telescope) | `ff` files, `fg` grep, `fb` buffers, `fd` definitions |
| `<leader>g` | Git | `gb` blame, `gd` diffview, `gr` GitLab review |
| `<leader>d` | Diagnostics | `dd` toggle trouble, `dl` buffer diagnostics |
| `<leader>b` | Buffers | `bd` delete, `bn` next, `bp` previous |
| `<leader>w` | Windows | `wh/j/k/l` navigate, `wv` vsplit, `ws` hsplit |
| `<leader>p` | Notes (gitpad) | `pp` project, `pb` branch, `pd` daily |
| `<leader>t` | Terminal | `tt` toggle, `tn` new |
| `<leader>e` | File explorer | Toggle nvim-tree |
| `<leader>z` | Zen mode | Toggle distraction-free |

## LSP keymaps (set in `config/lsp.lua`)

- `gd` / `gD` - Go to definition / declaration
- `gr` - References
- `gi` - Implementation
- `K` - Hover documentation
- `<C-k>` - Signature help
- `<space>rn` - Rename
- `<space>ca` - Code actions
- `<space>f` - Format

## Active LSP servers

- **Lua**: lua_ls
- **Go**: gopls
- **Python**: ruff
- **Ruby**: ruby_lsp, sorbet (via bundler)
- **TypeScript/JavaScript**: typescript-tools.nvim (not tsserver)

## Key plugins

- **Telescope**: Fuzzy finder with fzy-native and live-grep-args
- **Treesitter**: Syntax highlighting and folding
- **nvim-cmp**: Completion
- **Mason**: LSP server management
- **gitsigns**: Git integration in gutter
- **diffview**: Git diff viewer
- **gitlab.nvim**: GitLab MR review
- **which-key**: Keymap popup helper
- **trouble.nvim**: Diagnostics list
- **formatter.nvim**: Code formatting (prettier, eslint_d, rubocop, gofmt, stylua)

## Theme

- Active: kanagawa-wave (dark)
- Alternatives available: catppuccin, dracula, nightfox, gruvbox, vague, posterpole
