-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins", rocks = {
			enabled = false,
		} },
		{
			"VonHeikemen/lsp-zero.nvim",
			dependencies = {
				-- LSP Support
				"neovim/nvim-lspconfig",
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				-- Autocompletion
				"hrsh7th/nvim-cmp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"f3fora/cmp-spell",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"milanglacier/minuet-ai.nvim",
				-- Snippets
				"L3MON4D3/LuaSnip",
				"rafamadriz/friendly-snippets",
			},
			config = function()
				-- NOTE: to make any of this work you need a language server.
				-- If you don't know what that is, watch this 5 min video:
				-- https://www.youtube.com/watch?v=LaS32vctfOY

				-- Reserve a space in the gutter
				vim.opt.signcolumn = "yes"

				-- Add cmp_nvim_lsp capabilities settings to lspconfig
				-- This should be executed before you configure any language server
				local lspconfig_defaults = require("lspconfig").util.default_config
				lspconfig_defaults.capabilities = vim.tbl_deep_extend(
					"force",
					lspconfig_defaults.capabilities,
					require("cmp_nvim_lsp").default_capabilities()
				)

				-- This is where you enable features that only work
				-- if there is a language server active in the file
				vim.api.nvim_create_autocmd("LspAttach", {
					desc = "LSP actions",
					callback = function(event)
						local opts = { buffer = event.buf }

						vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
						vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
						vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
						vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
						vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
						vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
						vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
						vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
						vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
						vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
					end,
				})

				-- You'll find a list of language servers here:
				-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
				-- These are example language servers.
				require("lspconfig").eslint.setup({
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
					root_dir = require("lspconfig").util.root_pattern(
						".eslintrc",
						".eslintrc.cjs",
						".eslintrc.json",
						"package.json"
					),
				})
				require("lspconfig").volar.setup({
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
				})
				require("lspconfig").ts_ls.setup({})
				require("lspconfig").lua_ls.setup({
					config = function()
						require("plugins.configs.lspconfig")
						require("custom.configs.lspconfig")
					end,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})

				local cmp = require("cmp")

				cmp.setup({
					sources = {
						{ name = "nvim_lsp" },
					},
					snippet = {
						expand = function(args)
							-- You need Neovim v0.10 to use vim.snippet
							vim.snippet.expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({}),
				})

				require("mason").setup({
					opts = {
						ensure_installed = {
							"black",
						},
					},
				})
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = { "lua", "python", "javascript", "typescript", "vue" },
					ingnore_installed = { "org", "txt" },
					sync_install = false,
					highlight = { enable = true },
					indent = { enable = true },
				})
			end,
		},
		{
			"yetone/avante.nvim",
			event = "VeryLazy",
			lazy = false,
			version = false, -- set this if you want to always pull the latest change
			-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
			build = "make",
			-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"stevearc/dressing.nvim",
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				--- The below dependencies are optional,
				"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
				"zbirenbaum/copilot.lua", -- for providers='copilot'
				{
					-- support for image pasting
					"HakonHarnes/img-clip.nvim",
					event = "VeryLazy",
					opts = {
						-- recommended settings
						default = {
							embed_image_as_base64 = false,
							prompt_for_file_name = false,
							drag_and_drop = {
								insert_mode = true,
							},
							-- required for Windows users
							use_absolute_path = true,
						},
					},
				},
				{
					-- Make sure to set this up properly if you have lazy=true
					"MeanderingProgrammer/render-markdown.nvim",
					opts = {
						file_types = { "markdown", "Avante" },
					},
					ft = { "markdown", "Avante" },
				},
				{
					"nvim-orgmode/orgmode",
					event = "VeryLazy",
					ft = { "org" },
					config = function()
						-- Setup orgmode
						require("orgmode").setup({
							org_agenda_files = { "~/org/*", "~/org/**/*" },
							org_default_notes_file = "~/org/refile.org",
						})

						-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
						-- add ~org~ to ignore_install
						-- require('nvim-treesitter.configs').setup({
						--   ensure_installed = 'all',
						--   ignore_install = { 'org' },
						-- })
					end,
				},
			},
		},
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "tokyonight-moon" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
