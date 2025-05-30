-- [[ plugins.lua ]]
return {
  -- [[ Core dependencies ]]
  { "nvim-lua/plenary.nvim",        lazy = true },
  { "kyazdani42/nvim-web-devicons", lazy = true },

  -- [[ UI and Theme ]]
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
      git = { enable = true },
      renderer = { highlight_git = true },
    },
  },

  -- [[ Theme Collection ]]
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = false,
    },
  },
  { "Mofiqul/dracula.nvim",     priority = 1000, lazy = false },
  { "EdenEast/nightfox.nvim",   priority = 1000, lazy = false },
  { "ellisonleao/gruvbox.nvim", priority = 1000, lazy = false },
  { "rebelot/kanagawa.nvim",    priority = 1000, lazy = false },
  { "vague2k/vague.nvim",       priority = 1000, lazy = false },

  -- [[ Adaptive Theme ]]
  {
    "ilof2/posterpole.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("posterpole").setup({
        -- config here
      })
      vim.cmd("colorscheme posterpole")
      require("posterpole").setup_adaptive()
    end,
  },

  -- [[ Fuzzy Finder ]]
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
    opts = {
      extensions = {
        fzy_native = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    },
  },

  -- [[ LSP and Completion ]]
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },
  { "neovim/nvim-lspconfig",      event = "VeryLazy" },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
  },

  -- [[ Git Integration ]]
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "│" },
      },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
  },

  -- [[ Editor Enhancement ]]
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = "kyazdani42/nvim-web-devicons",
  },

  -- [[ Terminal ]]
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle" },
  },

  -- [[ Rails Support ]]
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },
  {
    "tpope/vim-rake",
    ft = "ruby",
  },
  {
    "tpope/vim-projectionist",
    ft = { "ruby", "javascript", "typescript" },
  },

  -- [[ Formatting ]]
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    config = function()
      local util = require("formatter.util")
      local prettierConfig = function()
        return {
          exe = "prettier",
          args = { "--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)) },
          stdin = true,
        }
      end

      require("formatter").setup({
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          json = { prettierConfig },
          html = { prettierConfig },
          javascript = { prettierConfig },
          typescript = { prettierConfig },
          typescriptreact = { prettierConfig },
          go = {
            function()
              return {
                exe = "gofmt",
                stdin = true,
              }
            end,
          },
          lua = {
            require("formatter.filetypes.lua").stylua,
            function()
              if util.get_current_buffer_file_name() == "special.lua" then
                return nil
              end
              return {
                exe = "stylua",
                args = {
                  "--search-parent-directories",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--",
                  "-",
                },
                stdin = true,
              }
            end,
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })
    end,
  },

  -- [[ Misc ]]
  { "mhinz/vim-startify",         lazy = false },
  { "danilamihailov/beacon.nvim", event = "VeryLazy" },
  { "tpope/vim-repeat",           event = "VeryLazy" },
  { "wakatime/vim-wakatime",      lazy = false },

  -- [[ Keybinding Help ]]
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      operators = { gc = "Comments" },
      key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
      },
      window = {
        border = "rounded",
        padding = { 1, 2, 1, 2 },
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "center",
      },
      ignore_missing = true,
      show_help = true,
      triggers = "auto",
    },
  },
}
