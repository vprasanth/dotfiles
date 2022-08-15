--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- IMPORTS
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps
-- require('plugins')      -- Plugins

-- PLUGINS
-- require('nvim-tree').setup{}
-- require('lualine').setup {
--     options = {
--         theme = 'dracula-nvim'
--     }
-- }
-- require('telescope').setup {
--     extensions = {
--         fzy_native = {
--             override_generic_sorter = false,
--             override_file_sorter = true,
--         }
--     }
-- }
-- require('telescope').load_extension('fzy_native')
