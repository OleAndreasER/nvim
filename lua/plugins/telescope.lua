return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim', 'm-demare/attempt.nvim' },
	config = function()
		local actions = require('telescope.actions')
		require('telescope').setup({
			defaults = { color_devicons = false },

		})
		local function browse(x)
			return '<cmd>Telescope ' .. x .. ' sort_mru=true sort_lastused=true initial_mode=normal<cr>'
		end

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>tf', builtin.git_files)
		vim.keymap.set('n', '<leader>tb', builtin.git_branches)
		vim.keymap.set('n', '<leader>tg', builtin.live_grep)
		vim.keymap.set('n', '<leader>tc', builtin.grep_string)
		vim.keymap.set('n', '<leader>tt', builtin.builtin)
		vim.keymap.set('n', '<leader>to', browse('buffers'))
		vim.keymap.set('n', '<leader>td', builtin.lsp_definitions)
		vim.keymap.set('n', '<leader>tD', builtin.lsp_type_definitions)
		vim.keymap.set('n', '<leader>tr',  browse('lsp_references'))
		vim.keymap.set('n', '<leader>ta', browse('attempt'))
		vim.keymap.set('n', '<leader>te', browse('diagnostics'))

		require('telescope').load_extension('attempt')
	end
}
