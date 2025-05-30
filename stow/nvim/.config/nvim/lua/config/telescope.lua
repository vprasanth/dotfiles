--[[ telescope.lua ]]
-- Telescope configuration

local M = {}

M.setup = function()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    },
  })

  -- Load extensions
  telescope.load_extension("fzy_native")
  telescope.load_extension("live_grep_args")
end

return M 