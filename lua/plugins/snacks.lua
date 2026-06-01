
vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require('snacks').setup({
	bigfile = { enabled = true },

	dashboard = { enabled = false },
	explorer = { enabled = false },
	input = { enabled = false },
	picker = { enabled = false },
	terminal = { enabled = false },
	notifier = { enabled = false },
	quickfile = { enabled = false },
	scope = { enabled = false },
	scroll = { enabled = false },
	statuscolumn = { enabled = false },
	words = { enabled = false },
	indent = {
		animate = { enabled = false },
		scope = { enabled = false },
	},
})

