--[[ init.lua ]]
-- Neovim initialization file
-- This is the main entry point for Neovim configuration.
-- It bootstraps the plugin manager and loads all other configuration files.

-- [[ Performance Optimizations ]]
-- Disable unused built-in plugins
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Optimize startup time
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- Reduce update time for better performance
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500

-- Optimize for large files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

-- [[ Bootstrap ]]
-- Bootstrap lazy package manager
-- This section ensures that lazy.nvim is installed and available.
-- If it's not installed, it will be cloned from the official repository.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- [[ Leader Keys ]]
-- Set global leader keys for key mappings
-- These keys are used as prefixes for custom key mappings throughout the config
vim.g.mapleader = "," -- Main leader key
vim.g.localleader = "\\" -- Local leader key for filetype-specific mappings

-- [[ Core Configuration ]]
-- Initialize lazy.nvim with our plugin specifications
-- This loads all plugins defined in plugins.lua
require("lazy").setup(require("plugins"), {
	defaults = { lazy = true }, -- Lazy load plugins by default
	install = { colorscheme = { "kanagawa-wave" } }, -- Default colorscheme
	checker = { enabled = true }, -- Check for plugin updates
	change_detection = { notify = false }, -- Don't notify on config changes
	performance = {
		rtp = {
			disabled_plugins = disabled_built_ins,
		},
	},
	rocks = {
		enabled = false, -- Disable LuaRocks support
	},
})

-- [[ Core Modules ]]
-- Load essential configuration modules
require("vars") -- Global variables and settings
require("opts") -- Editor options and settings
require("keys") -- Key mappings

-- [[ Plugin Configurations ]]
-- Load and setup plugin configurations from the config directory
-- Each plugin's configuration is in its own file under lua/config/
local configs = {
	"lsp", -- Language Server Protocol configuration
	"cmp", -- Completion configuration
	"telescope", -- Fuzzy finder configuration
	"diagnostics", -- Diagnostic display and navigation
}

-- Dynamically load and setup each plugin configuration
for _, config in ipairs(configs) do
	local ok, module = pcall(require, "config." .. config)
	if ok then
		if module.setup then
			module.setup()
		end
	end
end

-- [[ Additional Plugin Setup ]]
-- Direct plugin configurations that don't need their own files
-- These are simpler configurations that can be defined inline

-- NvimTree: File explorer configuration
require("nvim-tree").setup({
	disable_netrw = true, -- Disable netrw (built-in file explorer)
	hijack_netrw = true, -- Take over netrw's functionality
	respect_buf_cwd = true, -- Respect buffer's current working directory
	sync_root_with_cwd = true, -- Keep root directory in sync with cwd
	actions = {
		change_dir = {
			enable = false, -- Disable automatic directory changing
		},
	},
	view = {
		float = {
			enable = false, -- Disable floating window
		},
	},
})

-- Lualine: Status line configuration
require("lualine").setup({
	options = {
		theme = "dracula-nvim", -- Use dracula theme for status line
	},
})

-- Gitlinker: Git URL handling
require("gitlinker").setup({
	callbacks = {
		["repos%.fullscript%.io"] = function(url_data)
			url_data.host = "git.fullscript.io"
			return require("gitlinker.hosts").get_gitlab_type_url(url_data)
		end,
	},
})

-- Additional plugin configurations
require("gitsigns").setup() -- Git signs in the gutter
require("ibl").setup() -- Indent blankline
require("trouble").setup() -- Quickfix and location list
require("leap").add_default_mappings() -- Enhanced motion
require("neoscroll").setup() -- Smooth scrolling
