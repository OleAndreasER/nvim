return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function ()
			require("mason-lspconfig").setup({
				automatic_enable = true
			})
			-- vim.lsp.config('lua_ls', {
			-- 	settings = {
			-- 		Lua = {
			-- 			runtime = {
			-- 				version = 'LuaJIT',
			-- 			},
			-- 			workspace = {
			-- 				library = vim.api.nvim_get_runtime_file("", true),
			-- 			},
			-- 		}
			-- 	}
			-- })
			--
			-- vim.lsp.config('eslint', {
			-- 	on_attach = function (client, bufnr)
			-- 		vim.api.nvim_create_autocmd("BufWritePre", {
			-- 			buffer = bufnr,
			-- 			pattern = "*.{ts,js,vue}",
			-- 			command = "silent! EslintFixAll",
			-- 		})
			-- 	end
			-- })
			--
			-- vim.lsp.config('ts_ls', {
			-- 	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			-- 	init_options = {
			-- 		plugins = {
			-- 			-- https://github.com/vuejs/language-tools
			-- 			{
			-- 				name = "@vue/typescript-plugin",
			-- 				location = require("mason-registry")
			-- 					.get_package("vue-language-server")
			-- 					:get_install_path() .. "/node_modules/@vue/language-server",
			-- 				languages = { "vue" },
			-- 			},
			-- 		},
			-- 	},
			-- })
		end
	},
}
