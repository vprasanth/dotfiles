-- [[ plugins ]]

return {
	-- [[ context ]]
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = "kyazdani42/nvim-web-devicons",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.x",
		dependencies = "nvim-lua/plenary.nvim",
	},
	"nvim-treesitter/nvim-treesitter",
	"nvim-telescope/telescope-fzy-native.nvim",

	-- [[ nice to have ]]
	{ "mhinz/vim-startify", lazy = false },
	"danilamihailov/beacon.nvim",

	-- [[ themes ]]
	{ "Mofiqul/dracula.nvim", lazy = false },
	"EdenEast/nightfox.nvim",
	"ellisonleao/gruvbox.nvim",
	"rebelot/kanagawa.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },

	-- [[ coding ]]
	-- { "sbdchd/neoformat", lazy = false },
	{ "mhartington/formatter.nvim", lazy = false },
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp", -- Autocompletion plugin
	"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
	"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
	"L3MON4D3/LuaSnip", -- Snippets plugin
	{
		"ruifm/gitlinker.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	"lewis6991/gitsigns.nvim",
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"folke/trouble.nvim",
	"tpope/vim-repeat",
	"ggandor/leap.nvim",
	{ "wakatime/vim-wakatime", lazy = false },
	"simrat39/symbols-outline.nvim",
	{ "f-person/git-blame.nvim", lazy = true },
	"karb94/neoscroll.nvim",
	"voldikss/vim-floaterm",
}
