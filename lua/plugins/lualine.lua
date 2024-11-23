return {
	'nvim-lualine/lualine.nvim',
	config = function()
		require('lualine').setup({
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			winbar = {
				lualine_a = {
					{
						'filename',
						symbols = {
							unnamed = '',
							modified = modifiedSymbol,
							readonly = '',
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {'branch'},
				lualine_y = {},
				lualine_z = {}
			},
			inactive_winbar = {
				lualine_a = {
					{
						'filename',
						symbols = {
							unnamed = '',
							modified = modifiedSymbol,
							readonly = '',
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			extensions = { }
		})
	end,
}
