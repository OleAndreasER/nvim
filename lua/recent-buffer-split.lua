local buffer = vim.api.nvim_create_buf(false, true)
local ns = vim.api.nvim_create_namespace("recent-buffers-split")

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local output = vim.api.nvim_exec('ls t', true)
		local lines = { 'Recent files' }
		local icon_hls = { }

		local current_file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
		if current_file ~= '' and current_file ~= '[No Name]' then
			local current_icon, current_hl  = MiniIcons.get('file', current_file)
			local current_formatted_line = ' ' .. current_icon .. ' ' .. current_file 
			table.insert(lines, current_formatted_line)
			table.insert(icon_hls, current_hl)
		end

		for line in output:gmatch("[^\n]+") do
			local path = string.match(line, '"([^"]+)"')
			local filename = vim.fn.fnamemodify(path, ':t')

			if filename == current_file then goto continue end
			if filename == '' then goto continue end
			if filename == '[No Name]' then goto continue end

			local icon, hl = MiniIcons.get('file', filename)
			local formatted_line = ' ' .. icon .. ' ' .. filename
			table.insert(lines, formatted_line)
			table.insert(icon_hls, hl)

			::continue::
		end

		vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
		vim.api.nvim_buf_add_highlight(buffer, ns, "Title", 0, 0, -1)
		vim.api.nvim_buf_add_highlight(buffer, ns, "Underlined", 1, 6, -1)

		for i, hl in ipairs(icon_hls) do
			vim.api.nvim_buf_add_highlight(buffer, ns, hl, i, 1, 2)
		end

	end
})

Snacks.win({
	buf = buffer,
	position = "left",
	width = 0.12,
	enter = false,
})


