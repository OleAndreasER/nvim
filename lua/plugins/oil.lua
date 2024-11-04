return {
	'stevearc/oil.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local oil = require("oil")
		oil.setup({
			columns = {
				"icon"
			},
			watch_for_changes = true,
			keymaps = {
				["<C-s>"] = { "actions.select", opts = { vertical = true } },
				["-"] = "actions.parent",
				["g."] = "actions.toggle_hidden",
				["<esc>"] = "actions.close"
			},
			float = {
				border = "rounded",
				max_width = standard_float_width,
				max_height = standard_float_height,
				win_options = {
					winblend = 0,
				},
				get_win_title = function ()
					return ''
				end,

				-- Place at cursor
				override = function(conf)
					conf.col = 0
					conf.row = 0
					conf.relative = 'cursor'
					return conf
				end,
			},
			view_options = {
				show_hidden = false,
				-- This function defines what will never be shown, even when `show_hidden` is set
				is_always_hidden = function(name, bufnr)
					return name == '.git' or name == '..' 
				end,
				sort = {
					{ "type", "asc" },
					{ "name", "asc" },
				},
			},
		})

		vim.keymap.set("n", "-", oil.open_float)
	end
}
