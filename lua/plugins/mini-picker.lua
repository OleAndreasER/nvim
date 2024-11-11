return {
	{
		'echasnovski/mini.extra',
		version = false,
		config = function() 
			require('mini.extra').setup()
			vim.keymap.set('n', '<leader>b', MiniExtra.pickers.git_branches)
			vim.keymap.set('n', '<leader>e', MiniExtra.pickers.diagnostic)
			vim.keymap.set('n', '-', function() 
				MiniExtra.pickers.explorer({
					cwd = vim.fn.expand('%:p:h')
				})
			end)
		end
	},
	{
		'echasnovski/mini.pick',
		version = false,
		config = function()
			require('mini.pick').setup({
				mappings = {
					caret_left  = '<Left>',
					caret_right = '<Right>',

					choose            = '<CR>',
					choose_in_vsplit  = '=',

					move_down  = '<C-j>',
					move_up    = '<C-i>',

					stop = '<Esc>',
				},
			})

			vim.keymap.set('n', '<leader>f', function()
				MiniPick.builtin.files({},{
					source = {
						show = function(buf_id, items_arr, query)

							local file_names = vim.tbl_map(function(x)
								return string.len(vim.fn.fnamemodify(x, ':t'))
							end, items_arr)

							local max 
							if next(file_names) == nil then 
								max = 0
							else
								max = math.max(table.unpack(file_names))
							end

							MiniPick.default_show(buf_id, vim.tbl_map(function(x)
								local file_name = vim.fn.fnamemodify(x, ':t')
								local icon, hl, is_default = MiniIcons.get('file', file_name)
								return icon .. ' ' .. file_name .. string.rep(' ', max - string.len(file_name)) .. ' | ' .. vim.fn.fnamemodify(x, ':h')
							end, items_arr), query)
							
						end,
					}
				})
			end)
			vim.keymap.set('n', '<leader>h', MiniPick.builtin.help)
			vim.keymap.set('n', '<leader>s', MiniPick.builtin.grep_live)
			vim.keymap.set('n', '<leader>o', MiniPick.builtin.buffers)
			vim.keymap.set('n', '<leader><leader>', MiniPick.builtin.resume)
		end
	}
}
