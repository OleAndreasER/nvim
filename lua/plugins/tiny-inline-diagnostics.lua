
vim.pack.add({ { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" } })

require("tiny-inline-diagnostic").setup({
	preset = "minimal",
	options = {
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
		},
		multiline = { enabled = true, },
	},
})
vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "•",
			[vim.diagnostic.severity.WARN] = "•",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})
