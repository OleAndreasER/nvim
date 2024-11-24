return {
	'm-demare/attempt.nvim',
	config = function()
		local attempt = require('attempt')
		attempt.setup({
			ext_options = { '', 'js', 'ts' },
			format_opts = { [''] = 'Note' },
			run = {
				js = { 'w !node' },
				ts = { 'w !yarn tsx' },
			}
		})

		vim.keymap.set('n', '<leader>an', function()
			attempt.new({})
		end)
		vim.keymap.set('n', '<leader>ai', attempt.new_input_ext)
		vim.keymap.set('n', '<leader>ar', attempt.run)
		vim.keymap.set('n', '<leader>ad', attempt.delete_buf)
	end,
}
