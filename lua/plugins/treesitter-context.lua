return {
	'nvim-treesitter/nvim-treesitter-context',
	config = function()
		require('treesitter-context').setup({
			enable = true,
			max_lines = 0,
			trim_scope = 'outer',
			patterns = {
				default = {
					'class',
					'function',
					'method',
					-- 'for', -- These won't appear in the context
					-- 'while',
					-- 'if',
					-- 'switch',
					-- 'case',
				},
			},
			exact_patterns = {},
			zindex = 20,
			mode = 'cursor',
		})
	end,
};
