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
-- File explorer
keymap.set("n", "<LEADER>e", cmd("NvimTreeToggle"), { desc = "Toggle file explorer" })

-- [[ Search and Navigation ]]
-- Telescope mappings (quick access without leader)
keymap.set("n", "ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
keymap.set("n", "fg", function() require("telescope.builtin").live_grep() end, { desc = "Live grep" })
keymap.set("n", "fb", function() require("telescope.builtin").buffers() end, { desc = "Find buffers" })
keymap.set("n", "fh", function() require("telescope.builtin").help_tags() end, { desc = "Find help tags" })
keymap.set("n", "fm", function() require("telescope.builtin").marks() end, { desc = "Find marks" })
keymap.set("n", "ft", function() require("telescope.builtin").treesitter() end, { desc = "Find treesitter symbols" })
keymap.set("n", "fa", function() require("telescope.builtin").git_files() end, { desc = "Find git files" })
keymap.set("n", "fc", function() require("telescope.builtin").git_status() end, { desc = "Find git files from status" })
keymap.set("n", "fo", function() require("telescope.builtin").oldfiles() end, { desc = "Find old files" })
keymap.set("n", "fr", function() require("telescope.builtin").lsp_references() end, { desc = "Find LSP references" })
keymap.set("n", "fd", function() require("telescope.builtin").lsp_definitions() end, { desc = "Find LSP definitions" })
keymap.set("n", "fs", function() require("telescope.builtin").lsp_document_symbols() end, { desc = "Find LSP document symbols" })

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
keymap.set("n", "<LEADER>lr", function() require("telescope.builtin").lsp_references() end, { desc = "Find LSP references" })
keymap.set("n", "<LEADER>ld", function() require("telescope.builtin").lsp_definitions() end, { desc = "Find LSP definitions" })
keymap.set("n", "<LEADER>ls", function() require("telescope.builtin").lsp_document_symbols() end, { desc = "Find LSP document symbols" })

-- [[ Git Operations ]]
-- All git operations start with <LEADER>g
keymap.set("n", "<LEADER>gb", function() require("gitsigns").blame_line() end, { desc = "Git blame line" })
keymap.set("n", "<LEADER>gd", cmd("DiffviewOpen"), { desc = "Open diff view" })
keymap.set("n", "<LEADER>gc", cmd("DiffviewClose"), { desc = "Close diff view" })
keymap.set("n", "<LEADER>gs", function() require("telescope.builtin").git_status({ theme = "dropdown" }) end, { desc = "Find git status" })

-- [[ Terminal Operations ]]
-- All terminal operations start with <LEADER>t
keymap.set("n", "<LEADER>tt", cmd("FloatermToggle"), { desc = "Toggle terminal" })
keymap.set("n", "<LEADER>tn", cmd("FloatermNew"), { desc = "New terminal" })

-- [[ Diagnostics and Trouble ]]
-- All diagnostic operations start with <LEADER>d
keymap.set("n", "<LEADER>dd", cmd("TroubleToggle"), { desc = "Toggle trouble" })
keymap.set("n", "<LEADER>dw", cmd("TroubleToggle workspace_diagnostics"), { desc = "Toggle workspace diagnostics" })
keymap.set("n", "<LEADER>dl", cmd("TroubleToggle document_diagnostics"), { desc = "Toggle document diagnostics" })

-- [[ Formatting ]]
keymap.set("n", "<LEADER>f", cmd("Format"), { desc = "Format current buffer" })

-- [[ Zen Mode ]]
keymap.set("n", "<LEADER>z", cmd("ZenMode"), { desc = "Toggle zen mode" })
