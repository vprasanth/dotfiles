--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap
local telescope = lua
require("telescope.builtin")

-- remap the key used to leave insert mode
map("i", "jk", "<ESC>", {})

-- Toggle nvim-tree
map("n", "<LEADER>n", [[:NvimTreeToggle<cr>]], {})

-- Telescope
map("n", "ff", [[:Telescope find_files<cr>]], {})
map("n", "fg", [[:Telescope live_grep<cr>]], {})
map("n", "fb", [[:Telescope buffers<cr>]], {})
map("n", "fh", [[:Telescope help_tags<cr>]], {})
map("n", "fm", [[:Telescope marks<cr>]], {})
map("n", "ft", [[:Telescope treesitter<cr>]], {})
map("n", "fa", [[:Telescope git_files<cr>]], {})
map("n", "fr", [[:Telescope lsp_references<cr>]], {})
map("n", "fd", [[:Telescope lsp_definitions<cr>]], {})
map("n", "fs", [[:Telescope lsp_document_symbols<cr>]], {})
map("n", "fh", [[:Telescope oldfiles<cr>]], {})
map("n", "fc", [[:Telescope git_status theme=dropdown<cr>]], {})

-- Outline
map("n", "fS", [[:SymbolsOutline<cr>]], {})

-- " Using Lua functions
-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
