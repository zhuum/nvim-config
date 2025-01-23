return {
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Autocompletion
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"f3fora/cmp-spell",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- "milanglacier/minuet-ai.nvim",
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
}
