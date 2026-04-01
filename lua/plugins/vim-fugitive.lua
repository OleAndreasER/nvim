return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>c", [[:G commit -m ""<left>]])
		vim.keymap.set("n", "H", [[:G ]])
	end,
}
