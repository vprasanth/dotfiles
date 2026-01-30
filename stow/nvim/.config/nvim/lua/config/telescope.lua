--[[ telescope.lua ]]
-- Telescope configuration

local M = {}

M.setup = function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		pickers = {
			git_status = {
				layout_config = {
					width = { padding = 0.1 },
					height = { padding = 0.1 },
				},
			},
			find_files = {
				layout_config = {
					width = { padding = 0.1 },
					height = { padding = 0.1 },
				},
			},
			live_grep = {
				layout_config = {
					width = { padding = 0.1 },
					height = { padding = 0.1 },
				},
			},
		},
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-r>"] = function(bufnr)
						require("telescope.actions.set").edit(bufnr, "tab drop")
					end,
				},
			},
		},
	})

	-- Load extensions
	-- telescope.load_extension("fzy_native")
	-- telescope.load_extension("live_grep_args")
end

return M
