local current_terminal_bufname = 'Terminal 1'

return {
	'CRAG666/betterTerm.nvim',
	commit = '0d1c4e1',
	keys = {
		{
			mode = { 'n', 't', 'i' },
			'<C-e>',
			function()
				if vim.bo.ft == 'better_term' then
					require('betterTerm').open(vim.fn.bufname())
				else
					require('betterTerm').open(current_terminal_bufname)
				end
			end,
			desc = 'Toggle terminal',
		},
		{
			mode = { 't' },
			'<C-a>',
			function()
				if vim.bo.ft == 'better_term' then
					local current_terminal_index = tonumber(string.sub(vim.fn.bufname(), -1))
					if (current_terminal_index < 10) then
						local next_terminal_bufname = 'Terminal ' .. tonumber(string.sub(vim.fn.bufname(), -1)) + 1
						require('betterTerm').open(next_terminal_bufname)
						current_terminal_bufname = next_terminal_bufname
					end
				end
			end,
			desc = 'Open right terminal',
		},
		{
			mode = { 't' },
			'<C-d>',
			function()
				if vim.bo.ft == 'better_term' then
					local current_terminal_index = tonumber(string.sub(vim.fn.bufname(), -1))
					if current_terminal_index > 1 then
						local next_terminal_bufname = 'Terminal ' .. current_terminal_index - 1
						require('betterTerm').open(next_terminal_bufname)
						current_terminal_bufname = next_terminal_bufname
					end
				end
			end,
			desc = 'Open left terminal',
		},
	},
	opts = { 
		prefix = "Terminal ",
		index_base = 1,
		position = 'bot',
		size = 40,
	},
}
