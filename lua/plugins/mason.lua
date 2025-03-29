return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,

				['eslint'] = function()
					require("lspconfig").eslint.setup({})
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						pattern = "*.{ts,vue}",
						command = "EslintFixAll",
					})
				end,

				['denols'] = function ()
					require("lspconfig").denols.setup({})
				end,

				['ts_ls'] = function ()
					require("lspconfig").ts_ls.setup({
						filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
						init_options = {
							plugins = {
								-- https://github.com/vuejs/language-tools
								{
									name = '@vue/typescript-plugin',
									location = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server',
									languages = { 'vue' },
								},
							}
						}
					})
				end
			})
		end,
	},
}
