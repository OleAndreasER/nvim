return {
	{
		'tpope/vim-fugitive',
		config = function()
			vim.keymap.set({'n', 'v'}, '<leader>gg', ':G commit<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gP', ':G push<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gm', ':G pull origin master<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gp', ':G pull<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gs', '<cmd>Ge :<cr>5j', { silent = true })
		end,
	}
}
