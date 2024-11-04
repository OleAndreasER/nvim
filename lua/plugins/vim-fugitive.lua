return {
	'tpope/vim-fugitive',
	config = function()

		-- Fugitive in float (https://www.reddit.com/r/neovim/comments/1ag5mk3/fugitive_change_window_to_popup/)
		vim.api.nvim_create_user_command('FugitiveFloat', function()
			ui = vim.api.nvim_list_uis()[1]

			local width = 100
			local height = standard_float_height

			local win_config = {
				relative = "editor",
				width = width,
				height = height,
				col = (ui.width - width) / 2,
				row = (ui.height - height) / 2,
				style = 'minimal',
				focusable = true,
				border = 'rounded'
			}

			if not fugitive_float_bufnr then
				fugitive_float_bufnr = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_open_win(fugitive_float_bufnr, true, win_config)
				vim.cmd(':Gedit :')
				vim.cmd('normal 5j')
			elseif vim.api.nvim_win_get_buf(0) == fugitive_float_bufnr then
				vim.api.nvim_command('hide')
			else
				print('1234')
				vim.api.nvim_open_win(fugitive_float_bufnr, true, win_config)
				vim.cmd(':Gedit :')
				vim.cmd('normal 5j')
			end
		end, {})

		vim.keymap.set("n", "<leader>g", '<cmd>FugitiveFloat<cr>')
	end,
}
