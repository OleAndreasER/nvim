
vim.pack.add({ "https://github.com/echasnovski/mini.operators" })

require("mini.operators").setup({

	-- Multiply (duplicate) text
	multiply = {
		prefix = "M",
		func = nil,
	},

	-- Replace text with yanked
	replace = {
		prefix = "R",
		reindent_linewise = true,
	},
})
