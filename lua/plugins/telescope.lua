return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'm-demare/attempt.nvim',
		'nvim-tree/nvim-web-devicons',
		'BurntSushi/ripgrep',
		'nvim-telescope/telescope-fzf-native.nvim'
	},
	config = function()
		require('telescope').setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				entry_prefix = " ",

				vimgrep_arguments = {
					'rg',
					'--color=never',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
					'--smart-case',
					'--ignore-file',
					'.gitignore'
				},
				
				layout_config = {
					width = 0.95,
					height = 0.5,
				},

				results_title = false,

				borderchars = {
					results = { " ", " ", "─", "│", "│", " ", "─", "╰" },
					prompt = { "─", " ", " ", "│", "╭", "─", " ", "│" },
					preview = { "─", "│", "─", "│", "┬", "╮", "╯", "┴" },
				},
				file_ignore_patters = { "node_modules", '.git' } 	
			},
		})

		local standardTheme = 'layout_strategy=cursor sorting_strategy=ascending'

		local function browse(x)
			return '<cmd>Telescope ' .. x .. ' sort_mru=true sort_lastused=true initial_mode=normal ' .. standardTheme .. '<cr>'
		end

		local function search(x)
			return '<cmd>Telescope ' .. x .. ' sort_mru=true sort_lastused=true ' .. standardTheme .. '<cr>'
		end

		vim.keymap.set('n', '<leader>d', search("lsp_definitions"))
		vim.keymap.set('n', '<leader>r',  browse('lsp_references'))
	end
}
