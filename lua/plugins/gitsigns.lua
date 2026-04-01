return {
	'lewis6991/gitsigns.nvim',
	config = function()
		require('gitsigns').setup({
			signs = {
				add          = { text = ' ' },
				change       = { text = ' ' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = ' ' },
				untracked    = { text = ' ' },
			},
			signs_staged = {
				add          = { text = ' ' },
				change       = { text = ' ' },
				delete       = { text = ' ' },
				topdelete    = { text = ' ' },
				changedelete = { text = ' ' },
				untracked    = { text = ' ' },
			},
			signs_staged_enable = true,
			signcolumn = false,  -- Toggle with `:Gitsigns toggle_signs`
			numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true
			},
			auto_attach = true,
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			update_debounce = 100,
		})

		-- Delete diff highlight
		vim.keymap.set({ 'n' }, 'dn', function()
			require('gitsigns').toggle_linehl(false)
			require('gitsigns').toggle_signs(false)
		end)

		-- Stage buffer
		vim.keymap.set({ 'n', 'v' }, '<leader>l', function()
			vim.cmd('Gitsigns stage_buffer')

			local qf_title = vim.fn.getqflist({ idx = 0, title = 1 }).title or ''
			if qf_title == 'Hunks' then 
				vim.cmd('QfRemoveCurrentBuffer')	
			end
		end)

		-- Enable diff highlight and add to quickfix.
		vim.keymap.set({ 'n', 'v' }, '<leader>n', function()
			require('gitsigns').toggle_linehl(true)
			require('gitsigns').toggle_signs(true)
			require('gitsigns').setqflist(
				'all',
				{ open = false, }, 
				function (err)
					if not err then
						vim.cmd('QfFirst')
					end
				end)
			end)
		end,
	}
