# Neovim changes (2026-01-30)

Goals: faster startup, less waste, safer formatting.

- LSP stack now lazy-loads on first buffer (`BufReadPre/BufNewFile`) via `mason-lspconfig`; `cmp_nvim_lsp` is guarded with `pcall` so cmp stays lazy-friendly; no more forcing formatting capabilities on every server.
- Theme weight reduced: only `kanagawa` stays eager; other color schemes are lazy so they don’t load on start; devicons updated to maintained repo.
- Formatting hardened: formatter recipes skip when the binary is missing (prettier, gofmt, stylua) to prevent noisy failures; stylua wrapper adjusted accordingly.
- Removed duplicate timing tweaks from `init.lua` to avoid config drift and keep options centralized in `opts.lua`.
- Plugin keymaps now live with their plugin specs for clean lazy-loading (telescope, nvim-tree, trouble, diffview, floaterm, gitsigns).
- Telescope extensions now load in config; Treesitter `ensure_installed` expanded to common daily languages for consistent highlighting.

Next easy wins (optional):
- (Placeholder cleared – handled above.)
