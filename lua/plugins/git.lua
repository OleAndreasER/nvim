return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup({
				signs = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆' },
				},
				signs_staged = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆' },
				},
				attach_to_untracked = true,
			})
			vim.keymap.set({'n', 'v'}, '<leader>gp', ':Gitsigns preview_hunk_inline<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>ga', ':Gitsigns stage_buffer<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gU', ':Gitsigns reset_buffer<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gu', ':Gitsigns reset_hunk<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>g\'', function()
				require('gitsigns').setqflist('all', {
					open = false,
				})
			end, { silent = true })
			vim.keymap.set({'o', 'x'}, 'ih', '<Cmd>Gitsigns select_hunk<CR>')
		end
	},
	{
		'tpope/vim-fugitive',
		config = function()
			vim.keymap.set({'n', 'v'}, '<leader>gg', ':G commit<cr>', { silent = true })
		end,
	}
}
