return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		-- "rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = true,
			},
			cmdline = {
				view = "cmdline_popup",
				format = {
					cmdline = { conceal = false },
					search_down = { conceal = false },
					search_up = { conceal = false },
					filter = { conceal = false },
					lua = { conceal = false },
					help = { conceal = false },
					input = { conceal = false },
				},
			},
			views = {
				cmdline_popup = {
					position = {
						row = "40%",
						col = "50%",
					},
				},
			},
		})
	end,
}
