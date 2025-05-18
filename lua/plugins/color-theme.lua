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
			require("onedarkpro").load()
		end,
	},
}
