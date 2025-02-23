local buffer = vim.api.nvim_create_buf(false, true)

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",  -- This will match all buffers
	callback = function()
		local output = vim.api.nvim_exec('ls t', true)
		local lines = {}

		local current_file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
		local current_icon  = MiniIcons.get('file', current_file)
		local current_formatted_line = ' ' .. current_icon .. ' ' .. current_file 
		table.insert(lines, current_formatted_line)

		for line in output:gmatch("[^\n]+") do
			local path = string.match(line, '"([^"]+)"')
			local filename = vim.fn.fnamemodify(path, ':t')

			if filename == current_file then
				goto continue
			end

			local icon, hl = MiniIcons.get('file', filename)
			local formatted_line = ' ' .. icon .. ' ' .. filename 
			table.insert(lines, formatted_line)

			::continue::
		end

		vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
	end
})

local win = Snacks.win({
	buf = buffer,
	position = "left",
	width = 0.12,
	enter = false,
})


