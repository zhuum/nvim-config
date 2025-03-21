return {
	"nvim-orgmode/orgmode",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter", lazy = true },
	},
	build = ":TSUpdate",
	ft = { "org" },
	event = "BufReadPre",
	config = function()
		require("orgmode").setup({
			org_agenda_files = "~/org/**/*",
			org_default_notes_file = "~/org/refile.org",
		})
	end,
}
