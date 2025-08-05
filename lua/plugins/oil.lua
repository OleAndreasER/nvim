return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")
		oil.setup({
			skip_confirm_for_simple_edits = true,
			columns = {
				"icon",
			},
			default_file_explorer = false,
			watch_for_changes = false,
			use_default_keymaps = false,
			keymaps = {
				["<CR>"] = "actions.select",
				["-"] = "actions.parent",
				-- ["<esc>"] = "actions.close",
			},
			lsp_file_methods = {
				enabled = true,
				timeout_ms = 10000,
				autosave_changes = true,
			},
			-- Unused right now, but good settings
			float = {
				border = "single",
				max_width = 70,
				max_height = 40,
				win_options = {
					winblend = 0,
				},
				get_win_title = function()
					return ""
				end,

				-- Place at cursor
				override = function(conf)
					local row, col = unpack(vim.api.nvim_win_get_position(0))
					conf.col = col
					conf.row = row
					conf.relative = "cursor"
					return conf
				end,
			},
			view_options = {
				show_hidden = true,
				-- This function defines what will never be shown, even when `show_hidden` is set
				is_always_hidden = function(name, bufnr)
					return name == ".git" or name == ".."
				end,
				sort = {
					{ "type", "asc" },
					{ "name", "asc" },
				},
			},
		})
		vim.keymap.set("n", "-", "<cmd>Oil<cr>")
	end,
}
