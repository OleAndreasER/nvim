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
					'better_term',
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
						draw_empty = true,
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
						draw_empty = true,
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
			extensions = {
				{ -- Oil
					filetypes = { 'oil' },
					winbar = {
						lualine_a = {
							{
								function()
									local ok, oil pcall(require, 'oil')
									if ok then
										return vim.fn.fnamemodify(oil.get_current_dir(), ':~')
									else
										return ''
									end
								end,
							},
						},
					},
					inactive_winbar = {
						lualine_a = {
							{
								function()
									local ok, oil pcall(require, 'oil')
									if ok then
										return vim.fn.fnamemodify(oil.get_current_dir(), ':~')
									else
										return ''
									end
								end,
							},
						},
					},
				},
			},
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
