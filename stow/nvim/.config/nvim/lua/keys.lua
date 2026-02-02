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

-- [[ Notes/Review ]]
local function copy_file_line_ref()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("No file name for current buffer", vim.log.levels.WARN)
    return
  end
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local git_dir = vim.fs.find(".git", { upward = true, path = vim.fs.dirname(file) })[1]
  if git_dir then
    local root = vim.fs.dirname(git_dir)
    if vim.startswith(file, root .. "/") then
      file = file:sub(#root + 2)
    end
  else
    file = vim.fn.fnamemodify(file, ":.")
  end
  local ref = string.format("%s:%d", file, line)
  vim.fn.setreg('"', ref)
  if vim.fn.has("clipboard") == 1 then
    vim.fn.setreg("+", ref)
  end
  vim.notify("Copied reference: " .. ref)
end
keymap.set("n", "<LEADER>pl", copy_file_line_ref, { desc = "Copy file:line reference" })

-- LSP keymaps live in config/lsp.lua (gd/gr/...) and Telescope mappings in plugins.lua.

-- [[ Zen Mode ]]
keymap.set("n", "<LEADER>z", cmd("ZenMode"), { desc = "Toggle zen mode" })
