return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				TSConfig = {},
				auto_install = true,
				ensure_installed = { "org", "lua", "python", "javascript", "typescript", "vue" },
				ignore_install = { "txt" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
