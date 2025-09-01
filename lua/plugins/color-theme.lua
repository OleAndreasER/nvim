return {
	{
		'nyoom-engineering/oxocarbon.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd('colorscheme oxocarbon')
		end,
	},
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
		lazy = false,
		priority = 1000,
		config = function()
			require('ayu').setup({
				mirage = false,
				terminal = true,
				overrides = {},
			})
			-- vim.cmd(':colorscheme ayu');
		end
	},
	{
		"rijulpaul/nightblossom.nvim",
		name = "nightblossom",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme nightblossom-pastel")
		end,
	}
}
