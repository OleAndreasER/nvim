
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
vim.pack.add({ "https://github.com/Wansmer/treesj" })

require('treesj').setup({
	use_default_keymaps = false,
	max_join_length = 100000000000000000,
})
vim.keymap.set("n", "<leader>m", require('treesj').toggle)

