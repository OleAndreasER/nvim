return {
	"nvim-lualine/lualine.nvim",
	dependencies = "chrisgrieser/nvim-recorder",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = " ", right = "" },
				disabled_filetypes = {
					'better_term'
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			winbar = {
				lualine_a = {
					{
						"filename",
						symbols = {
							unnamed = "",
							modified = modifiedSymbol,
							readonly = "",
						},
					},

					-- For debugging
					-- 'bo:filetype'
				},
				lualine_b = { require("recorder").recordingStatus },
				lualine_c = {},
				lualine_x = { "branch" },
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {
					{
						"filename",
						symbols = {
							unnamed = "",
							modified = modifiedSymbol,
							readonly = "",
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {},
		})

		vim.api.nvim_set_hl(0, "lualine_c_normal", {
			fg = "",
			bg = "",
			italic = false,
			underline = false,
			sp = "",
		})

		vim.api.nvim_set_hl(0, "lualine_a_inactive", {
			link = "Title",
		})

	end,
}
