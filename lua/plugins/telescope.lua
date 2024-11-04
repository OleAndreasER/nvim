return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim', 'm-demare/attempt.nvim', 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('telescope').setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				entry_prefix = " ",

				layout_config = {
					width = 0.5,
					height = 0.4,
				},

				results_title = false,

				borderchars = {
					results = { " ", " ", "─", "│", "│", " ", "─", "╰" },
					prompt = { "─", " ", " ", "│", "╭", "─", " ", "│" },
					preview = { "─", "│", "─", "│", "┬", "╮", "╯", "┴" },
				}

			},
		})

		local standardTheme = 'layout_strategy=cursor sorting_strategy=ascending'

		local function browse(x)
			return '<cmd>Telescope ' .. x .. ' sort_mru=true sort_lastused=true initial_mode=normal ' .. standardTheme .. '<cr>'
		end

		local function search(x)
			return '<cmd>Telescope ' .. x .. ' sort_mru=true sort_lastused=true ' .. standardTheme .. '<cr>'
		end

		vim.keymap.set('n', '<leader>tf', search("git_files"))
		vim.keymap.set('n', '<leader>tb', search("git_branches"))
		vim.keymap.set('n', '<leader>tg', search("live_grep"))
		vim.keymap.set('n', '<leader>tc', search("grep_string"))
		vim.keymap.set('n', '<leader>tt', search("builtin"))
		vim.keymap.set('n', '<leader>to', browse('buffers'))
		vim.keymap.set('n', '<leader>td', search("lsp_definitions"))
		vim.keymap.set('n', '<leader>tD', search("lsp_type_definitions"))
		vim.keymap.set('n', '<leader>tr',  browse('lsp_references'))
		vim.keymap.set('n', '<leader>ta', browse('attempt'))
		vim.keymap.set('n', '<leader>te', browse('diagnostics'))

		require('telescope').load_extension('attempt')
	end
}
