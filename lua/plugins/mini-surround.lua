return {
	"echasnovski/mini.surround",
	config = function()
		require('mini.surround').setup({
			custom_surroundings = nil,
			highlight_duration = 500,
			n_lines = 20,
			respect_selection_type = false,
			search_method = 'cover',
			silent = false,
			mappings = {
				add = 'sa',
				delete = 'sd',
				find = '',
				find_left = '',
				highlight = '',
				replace = 'sr',
				update_n_lines = '',

				suffix_last = 'l',
				suffix_next = 'n',
			},
		})
	end
}
