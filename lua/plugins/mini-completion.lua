return {
	'echasnovski/mini.completion',
	version = false,
	config = function ()
		require('mini.completion').setup({
			delay = { completion = 100, info = 100, signature = 50 },

			window = {
				info = { height = 25, width = 80, border = nil },
				signature = { height = 25, width = 80, border = nil },
			},

			lsp_completion = {
				source_func = 'completefunc',
				auto_setup = true,
				process_items = nil,
				snippet_insert = nil,
			},
			fallback_action = '<C-n>',

			mappings = {
				force_twostep = '<C-Space>',
				force_fallback = '<A-Space>',

				scroll_down = '<C-f>',
				scroll_up = '<C-b>',
			},

			set_vim_settings = true,
		})
	end
}
