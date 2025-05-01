return {
	{
		'tpope/vim-fugitive',
		config = function()
			vim.keymap.set({'n', 'v'}, '<leader>g', '<cmd>Ge :<cr>5j', { silent = true })
		end,
	}
}
