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
						pattern = "*.ts",
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
				end
			})
		end,
	},
}
