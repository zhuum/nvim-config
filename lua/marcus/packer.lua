
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
          requires = { {'nvim-lua/plenary.nvim'} },
          config = {
              theme = "dropdown",
              layout_strategy = "vertical",
          }

  }

  use { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }
  use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }

  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use ('mbbill/undotree')
  use ('tpope/vim-fugitive')

  use {
 	  'VonHeikemen/lsp-zero.nvim',
 	  requires = {
 		  -- LSP Support
 		  {'neovim/nvim-lspconfig'},
 		  {'williamboman/mason.nvim'},
 		  {'williamboman/mason-lspconfig.nvim'},
 		  -- Autocompletion
 		  {'hrsh7th/nvim-cmp'},
 		  {'hrsh7th/cmp-buffer'},
 		  {'hrsh7th/cmp-path'},
 		  {'saadparwaiz1/cmp_luasnip'},
 		  {'hrsh7th/cmp-nvim-lsp'},
 		  {'hrsh7th/cmp-nvim-lua'},
 		  -- Snippets
 		  {'L3MON4D3/LuaSnip'},
 		  {'rafamadriz/friendly-snippets'},
 	  }
  }

  use {'nvim-orgmode/orgmode', config = function()
      require('orgmode').setup{}
  end
}
end)
