--[[ keys.lua ]]
-- Key mappings for Neovim
-- All key mappings are organized by functionality and use consistent prefixes
-- <LEADER> is set to ',' in init.lua

local keymap = vim.keymap

-- Helper functions for common operations
local function cmd(str)
  return function()
    vim.cmd(str)
  end
end

-- [[ Insert Mode Mappings ]]
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- [[ File Operations ]]
-- (plugin-specific mappings live in plugin specs for lazy loading)

-- [[ Buffer Management ]]
-- All buffer operations start with <LEADER>b
keymap.set("n", "<LEADER>bd", cmd("bd"), { desc = "Delete current buffer" })
keymap.set("n", "<LEADER>bn", cmd("bn"), { desc = "Next buffer" })
keymap.set("n", "<LEADER>bp", cmd("bp"), { desc = "Previous buffer" })
keymap.set("n", "<LEADER>bl", cmd("ls"), { desc = "List buffers" })

-- [[ Window Management ]]
-- All window operations start with <LEADER>w
keymap.set("n", "<LEADER>wh", function() vim.cmd.wincmd("h") end, { desc = "Move to left window" })
keymap.set("n", "<LEADER>wj", function() vim.cmd.wincmd("j") end, { desc = "Move to bottom window" })
keymap.set("n", "<LEADER>wk", function() vim.cmd.wincmd("k") end, { desc = "Move to top window" })
keymap.set("n", "<LEADER>wl", function() vim.cmd.wincmd("l") end, { desc = "Move to right window" })
keymap.set("n", "<LEADER>w=", function() vim.cmd.wincmd("=") end, { desc = "Equalize window sizes" })
keymap.set("n", "<LEADER>wv", function() vim.cmd.wincmd("v") end, { desc = "Split window vertically" })
keymap.set("n", "<LEADER>ws", function() vim.cmd.wincmd("s") end, { desc = "Split window horizontally" })

-- [[ LSP Operations ]]
-- All LSP operations start with <LEADER>l
keymap.set("n", "<LEADER>lr", vim.lsp.buf.references, { desc = "Find LSP references" })
keymap.set("n", "<LEADER>ld", vim.lsp.buf.definition, { desc = "Find LSP definitions" })
keymap.set("n", "<LEADER>ls", vim.lsp.buf.document_symbol, { desc = "Find LSP document symbols" })

-- [[ Zen Mode ]]
keymap.set("n", "<LEADER>z", cmd("ZenMode"), { desc = "Toggle zen mode" })
