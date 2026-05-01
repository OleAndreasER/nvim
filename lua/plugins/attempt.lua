
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })

vim.pack.add({ "https://github.com/m-demare/attempt.nvim" })

require("attempt").setup({
	ext_options = { "", "js", "ts" },
	format_opts = { [""] = "Note" },
})

vim.keymap.set("n", "<leader>a", require("attempt").new_input_ext)

