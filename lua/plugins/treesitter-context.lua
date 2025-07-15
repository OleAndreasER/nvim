return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("treesitter-context").setup({
			enable = true,
			max_lines = 1,
			trim_scope = "outer",
			patterns = {
				default = {
					-- "class",
					"function",
					"method",
					-- 'for',
					-- 'while',
					-- 'if',
					-- 'switch',
					-- 'case',
				},
			},
			exact_patterns = {},
			zindex = 20,
			mode = "cursor",
		})

		vim.api.nvim_set_hl(0, "TreesitterContext", {
			fg = "",
			bg = "",
			italic = false,
			underline = false,
			sp = "",
		})
	end,
}
