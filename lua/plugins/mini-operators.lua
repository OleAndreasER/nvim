return {
	"echasnovski/mini.operators",
	version = false,
	config = function()
		require("mini.operators").setup({

			-- Multiply (duplicate) text
			multiply = {
				prefix = "M",
				func = nil,
			},

			-- Replace text with register
			replace = {
				prefix = "R",
				reindent_linewise = true,
			},
		})
	end,
}
