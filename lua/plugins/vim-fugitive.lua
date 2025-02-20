return {
	'tpope/vim-fugitive',
	config = function()
		vim.keymap.set("n", "<leader>g", '<cmd>Ge :<cr>5j')
	end,
}
