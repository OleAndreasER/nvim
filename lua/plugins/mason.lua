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
		dependencies = { "mason.nvim", "hrsh7th/nvim-cmp", "artemave/workspace-diagnostics.nvim" },
		config = function()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					require("lspconfig")[server_name].setup({
						capabilities = capabilities
					})
				end,

				['eslint'] = function()
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					require("lspconfig").eslint.setup({
						capabilities = capabilities
					})
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						pattern = "*.{ts,vue}",
						command = "EslintFixAll",
					})
				end,

				['denols'] = function ()
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					require("lspconfig").denols.setup({
						capabilities = capabilities,
						on_attach = function (client, bufnr)
							require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
						end
					})
				end,

				['ts_ls'] = function ()
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					require("lspconfig").ts_ls.setup({
						capabilities = capabilities,
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
