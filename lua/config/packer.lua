return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = {
      theme = "dropdown",
      layout_strategy = "vertical",
    }

  }

  use { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }
  use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('HakonHarnes/img-clip.nvim')
  use('MeanderingProgrammer/render-markdown.nvim')
  use('yetone/avante.nvim')
  use('stevearc/dressing.nvim')
  use('MunifTanjim/nui.nvim')

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'f3fora/cmp-spell' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { "milanglacier/minuet-ai.nvim" },
      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use { 'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup({})
  end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use({
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "lua_ls" },
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format" }
            else
              return { "black" }
            end
          end,
          -- Conform will run the first available formatter
          javascript = { "eslint", "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      }
      )
    end,
  })

  use { 'nvimtools/none-ls.nvim' }
end)
