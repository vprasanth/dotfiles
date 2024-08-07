-- [[ plugins ]]

return {
  -- [[ context ]]
  -- Lua
  {
    "folke/zen-mode.nvim",
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
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
  { "mhinz/vim-startify",       lazy = false },
  "danilamihailov/beacon.nvim",

  -- [[ themes ]]
  { "Mofiqul/dracula.nvim",     lazy = false },
  { "EdenEast/nightfox.nvim",   lazy = false },
  { "ellisonleao/gruvbox.nvim", lazy = false },
  { "rebelot/kanagawa.nvim",    lazy = false },
  { "catppuccin/nvim",          name = "catppuccin" },

  -- [[ package manager ]]
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  -- [[ coding ]]
  { "mhartington/formatter.nvim",          lazy = false },
  "hrsh7th/nvim-cmp",        -- Autocompletion plugin
  "hrsh7th/cmp-nvim-lsp",    -- LSP source for nvim-cmp
  "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
  "L3MON4D3/LuaSnip",        -- Snippets plugin
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
  "lewis6991/gitsigns.nvim",
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  "folke/trouble.nvim",
  "tpope/vim-repeat",
  { "tpope/vim-surround",    lazy = false },
  "ggandor/leap.nvim",
  { "wakatime/vim-wakatime", lazy = false },
  "simrat39/symbols-outline.nvim",
  { "f-person/git-blame.nvim", lazy = true },
  "karb94/neoscroll.nvim",
  "voldikss/vim-floaterm",
  { "sindrets/diffview.nvim",  lazy = false },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  }
}
