return {
	'nvim-lualine/lualine.nvim',
	config = function()
		require('lualine').setup({
			options = {
				icons_enabled = false,
				theme = 'auto',
				component_separators = { left = '', right = ''},
				always_divide_middle = true,
				globalstatus = true,
			},
			winbar = {
				lualine_c = {
					'%=',
					{
						'filename',
						symbols = {
							unnamed = '',
							modified = modifiedSymbol,
							readonly = '',
						},
					},
					'%='
				},
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch' },
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			extensions = { }
		})
	end,
}
