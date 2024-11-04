return {
	'smithbm2316/centerpad.nvim',
	config = function ()
		vim.keymap.set('n', '<leader>z', function ()
			require('centerpad').toggle({ leftpad = 70, rightpad = 0 })
		end)
	end,
}
