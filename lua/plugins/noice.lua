return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	enabled = function()
		return not vim.g.neovide
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
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
