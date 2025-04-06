return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup({
				signs = {
					add          = { text = '│' },
					change       = { text = '│' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '│' },
					untracked    = { text = '┆' },
				},
				signs_staged = {
					add          = { text = ' ' },
					change       = { text = ' ' },
					delete       = { text = ' ' },
					topdelete    = { text = ' ' },
					changedelete = { text = ' ' },
					untracked    = { text = ' ' }
				},
				attach_to_untracked = true,
			})
			vim.keymap.set({'n', 'v'}, '<leader>go', ':Gitsigns preview_hunk_inline<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>ga', ':Gitsigns stage_buffer<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gA', ':Gitsigns stage_hunk<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gu', ':Gitsigns reset_buffer<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gU', ':Gitsigns reset_hunk<cr>', { silent = true })
			vim.keymap.set({'n', 'v'}, '<C-m>', function()
				require('gitsigns').setqflist('all', {
					open = false,
				})
			end, { silent = true })
			vim.keymap.set({'n', 'v'}, '<leader>gn', function()
				require('gitsigns').nav_hunk('next')
				require('gitsigns').preview_hunk_inline()
			end, { silent = true })
			vim.keymap.set({'o', 'x'}, 'ih', '<Cmd>Gitsigns select_hunk<CR>')
		end
	},
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
