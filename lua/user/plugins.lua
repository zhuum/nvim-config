-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {"akinsho/toggleterm.nvim"}
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require'nvim-tree'.setup {} end
    }
    use 'tpope/vim-rhubarb'

    -- cmp
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'

    -- color
    use 'shaunsingh/nord.nvim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    require('lualine').setup {
      options = {
        theme = 'nord'
      }
    }

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lua'
    use "jose-elias-alvarez/null-ls.nvim"

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        ensure_installed = { "http", "json" }
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use 'kchmck/vim-coffee-script'

    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      }
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use 'tpope/vim-fugitive'
    use {
      "NTBBloodbath/rest.nvim",
          requires = { "nvim-lua/plenary.nvim" },
          config = function()
            require("rest-nvim").setup({
              -- Open request results in a horizontal split
              result_split_horizontal = false,
              -- Skip SSL verification, useful for unknown certificates
              skip_ssl_verification = false,
              -- Highlight request on run
              highlight = {
                enabled = true,
                timeout = 150,
              },
              result = {
                -- toggle showing URL, HTTP info, headers at top the of result window
                show_url = true,
                show_http_info = true,
                show_headers = true,
              },
              -- Jump to request line on run
              jump_to_request = false,
              env_file = '.env',
              custom_dynamic_variables = {},
              yank_dry_run = true,
            })
          end
        }
end)
