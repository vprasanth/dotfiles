--[[ diagnostics.lua ]]
-- Diagnostics configuration
-- This module handles the configuration for Neovim's built-in diagnostics system.
-- It sets up keymaps for navigating and displaying diagnostic information.

local M = {}

-- Setup function for diagnostics configuration
M.setup = function()
  -- Diagnostic keymaps
  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Show diagnostics in location list" })

  -- Configure diagnostic sign text (replaces deprecated sign_define usage)
  local signs = {
    [vim.diagnostic.severity.ERROR] = "✗",
    [vim.diagnostic.severity.WARN] = "⚠",
    [vim.diagnostic.severity.INFO] = "ℹ",
    [vim.diagnostic.severity.HINT] = "💡",
  }

  -- Configure diagnostic display
  vim.diagnostic.config({
    virtual_text = true, -- Show virtual text
    signs = { text = signs }, -- Show signs in the sign column
    underline = true, -- Underline the text
    update_in_insert = false, -- Don't update diagnostics in insert mode
    severity_sort = true, -- Sort diagnostics by severity
    float = {
      border = "rounded", -- Use rounded borders for floating windows
      source = "always", -- Always show the source of the diagnostic
      header = "", -- No header in floating window
      prefix = "", -- No prefix for diagnostic messages
    },
  })
end

return M 
