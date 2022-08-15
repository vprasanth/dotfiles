-- [[ plug.lua ]]

return require('packer').startup(function(use)
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- [[ nice to have ]]
    use 'mhinz/vim-startify'
    use 'danilamihailov/beacon.nvim'
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- [[ themes ]]
    use 'Mofiqul/dracula.nvim'
end)
