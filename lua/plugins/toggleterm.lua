return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = '<c-k>',
			hide_numbers = true,
			autochdir = false,
			start_in_insert = true,
			persist_size = true,
			persist_mode = true,
			direction = 'float',
			shell = 'powershell',
			auto_scroll = true,
			float_opts = {
				border = 'curved',
				width = standard_float_width,
				height = standard_float_height,
				winblend = 0,
				title_pos = 'left',
			},
		})
	end,
}
