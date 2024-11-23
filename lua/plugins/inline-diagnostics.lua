return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
		vim.diagnostic.config({
			virtual_text = false,
			signs = false,
		})
		require('tiny-inline-diagnostic').setup({
			signs = {
				left = "",
				right = "",
				diag = "●",
				arrow = "    ",
				up_arrow = "    ",
				vertical = " │",
				vertical_end = " │",
			},
		})
	end
}
