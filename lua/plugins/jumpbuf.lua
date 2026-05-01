
vim.pack.add({ "https://github.com/kwkarlwang/bufjump.nvim" })

require("bufjump").setup({
	on_success = nil,
})

vim.api.nvim_set_keymap("n", "(", ":silent! lua require('bufjump').backward()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", ")", ":silent! lua require('bufjump').forward()<cr>", { silent = true })

