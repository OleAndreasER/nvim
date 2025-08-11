return {
	{
		"olimorris/onedarkpro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedarkpro").setup({
				colors = {
					onedark = {
						bg = "#23272e",
					},
				},
			})

			-- require("onedarkpro").load()
			-- vim.api.nvim_set_hl(0, "Normal", {
			-- 	fg = "",
			-- 	bg = "#23272e",
			-- })
			-- vim.api.nvim_set_hl(0, "FloatBorder", {
			-- 	link = "Normal",
			-- })
			-- vim.api.nvim_set_hl(0, "NormalFloat", {
			-- 	link = "Normal",
			-- })

		end,
	},
	{
		"Shatur/neovim-ayu",
		config = function()
			require('ayu').setup({
				mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
				terminal = true, -- Set to `false` to let terminal manage its own colors.
				overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
			})
			vim.cmd(':colorscheme ayu');
		end
	}
}
