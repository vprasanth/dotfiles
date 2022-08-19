-- [[ plug.lua ]]

return require('packer').startup(function(use)
    -- [[ context ]]
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- [[ nice to have ]]
    use 'mhinz/vim-startify'
    use 'danilamihailov/beacon.nvim'

    -- [[ themes ]]
    use 'Mofiqul/dracula.nvim'
    use "EdenEast/nightfox.nvim"

    -- [[ coding ]]
    use 'sbdchd/neoformat'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use {
        'ruifm/gitlinker.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }
end)
