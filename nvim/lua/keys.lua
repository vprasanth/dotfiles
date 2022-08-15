--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap
local telescope = lua require('telescope.builtin')

-- remap the key used to leave insert mode
map('i', 'jk', '<ESC>', {})

-- Toggle nvim-tree
map('n', '<LEADER>n', [[:NvimTreeToggle<cr>]], {})

-- Telescope
map('n', '<LEADER>ff', [[:Telescope find_files<cr>]], {})
map('n', '<LEADER>fg', [[:Telescope live_grep<cr>]], {})
map('n', '<LEADER>fb', [[:Telescope buffers<cr>]], {})
map('n', '<LEADER>fh', [[:Telescope help_tags<cr>]], {})

-- " Using Lua functions
-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
