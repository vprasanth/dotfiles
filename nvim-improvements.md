# Neovim Improvement Punchlist (2026-01-30)

Context: current config lives in `stow/nvim/.config/nvim`. Lazy.nvim is bootstrapped in `init.lua`; LSP is configured in `lua/config/lsp.lua`; plugins are declared in `lua/plugins.lua`; global options and keys are in `lua/opts.lua` and `lua/keys.lua`.

## Improvement ideas
- Defer the LSP stack (Mason + server configs) until you actually open a buffer: move `require("config.lsp").setup()` into the `mason-lspconfig` spec with `event = { "BufReadPre", "BufNewFile" }` and guard `require("cmp_nvim_lsp")` with `pcall` so cmp stays lazy and headless startup stays fast.
- Stop forcing multiple themes to load at startup: keep your chosen default (e.g., `kanagawa`) eager, but mark the other theme plugins as `lazy = true` (or remove them) to cut cold-start time and cache thrash.
- Tighten formatting: switch `formatter.nvim` to `conform.nvim` or add `vim.fn.executable` guards per formatter so missing binaries don’t throw; also avoid forcing `documentFormattingProvider = true` on every LSP client to prevent double-format sources.
- Trim duplicate perf tweaks: `updatetime`/`timeoutlen` are set in both `init.lua` and `opts.lua`; keep one source of truth to reduce config drift.
- Treesitter coverage is narrow (`ensure_installed = { "yaml" }`); expand to your daily stack (lua, ts/tsx/js, json, markdown, bash, vimdoc) so LSP highlighting never falls back to regex.
- Telescope extensions are declared but never loaded (`telescope-fzy-native`, `live_grep_args`); either load them in `config/telescope.lua` or drop the deps to avoid wasted installs.
- Move plugin-specific keymaps next to their specs (e.g., Trouble, Diffview, Floaterm, NvimTree) so lazy.nvim can auto-load on first use and mappings don’t reference missing commands if a plugin is removed.
- Replace legacy `kyazdani42/nvim-web-devicons` with `nvim-tree/nvim-web-devicons` to follow upstream moves and avoid breakage on future updates.

## Top 3 to fix now
1) Lazy-load the LSP stack (`mason[-lspconfig]` + cmp capabilities) on `BufReadPre/BufNewFile` with a `pcall` fallback for `cmp_nvim_lsp`.  
2) Make alternate themes lazy (or remove them) and keep only the active scheme eager.  
3) Harden formatting by guarding executables or moving to `conform.nvim`, and stop forcing `documentFormattingProvider` on every server.  
