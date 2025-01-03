return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'm-demare/attempt.nvim',
			'nvim-tree/nvim-web-devicons',
			"natecraddock/telescope-zf-native.nvim",
		},
		config = function()
			require('telescope').setup({
				defaults = {
					file_ignore_patterns = { "node_modules", '.git/' },
					prompt_prefix = "> ",
					selection_caret = "> ",
					entry_prefix = "  ",
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
					sorting_strategy = 'ascending',
					layout_config = {
						width = 0.95,
						height = 0.8,
						prompt_position = 'top',
					},
					results_title = false,
					borderchars = {
						results = { " ", " ", " ", " ", " ", " ", " ", " " },
						prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
						preview = { " ", " ", " ", " ", " ", " ", " ", " " },
					},
					path_display = {
						"tail"
					},
				},
			})

			local function browse(x)
				return '<cmd>Telescope ' .. x .. ' initial_mode=normal <cr>'
			end

			local function search(x)
				return '<cmd>Telescope ' .. x .. '<cr>'
			end

			vim.keymap.set('n', '<leader>d', search("lsp_definitions"))
			vim.keymap.set('n', '<leader>n', search("lsp_dynamic_workspace_symbols"))
			vim.keymap.set('n', '<leader>f', search("find_files"))
			vim.keymap.set('n', '<leader>r',  browse('lsp_references'))
			vim.keymap.set('n', '<leader>o',  browse('buffers'))
			vim.keymap.set('n', '<leader>h', search('help_tags'))
			vim.keymap.set('n', '<leader>s', search('live_grep') )
			vim.keymap.set('n', '<leader><leader>', browse('resume') )
			vim.keymap.set('n', '<leader>b', search('git_branches'))
			vim.keymap.set('n', '<leader>e', browse('diagnostics severity=error'))
			require("telescope").load_extension("zf-native")
		end
	},
}
