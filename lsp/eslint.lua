return {
	on_attach = function (client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			pattern = "*.{ts,js,vue}",
			command = "silent! EslintFixAll",
		})
	end
}
