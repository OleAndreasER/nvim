
vim.pack.add({ "https://github.com/hrsh7th/cmp-nvim-lsp" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-nvim-lua" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-buffer" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-path" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-cmdline" })

vim.pack.add({ "https://github.com/hrsh7th/nvim-cmp" })

require("cmp").setup({
	snippet = {},
	window = {},
	mapping = require("cmp").mapping.preset.insert({
		["<Tab>"] = require("cmp").mapping.select_next_item({ behavior = require("cmp").SelectBehavior.Select }),
		["<Enter>"] = require("cmp").mapping.confirm({
			behavior = require("cmp").ConfirmBehavior.Insert,
			select = true,
		}),
		['<C-Space>'] = require("cmp").mapping.complete(),
	}),
	sources = require("cmp").config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

