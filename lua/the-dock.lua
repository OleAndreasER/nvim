-- Recent buffers
local buffer = vim.api.nvim_create_buf(false, true)
local ns = vim.api.nvim_create_namespace("recent-buffers")

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local jumplist = vim.fn.getjumplist()
		local rjumplist = {}
		for i = #jumplist[1], 1, -1 do
			table.insert(rjumplist, jumplist[1][i])
		end

		local lines = { 'Recent files' }
		
		local icon_hls = { }

		local current_index = # jumplist[1] - jumplist[2]

		-- TODO ?

		-- local current_file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
		-- if current_index == 0 then
		-- 	local current_icon, current_hl  = MiniIcons.get('file', current_file)
		-- 	local current_formatted_line = ' ' .. current_icon .. ' ' .. current_file 
		-- 	table.insert(lines, current_formatted_line)
		-- 	table.insert(icon_hls, current_hl)
		-- end

		local previous_bufnr = -1
		local file_current_index = 0
		for i, entry in ipairs(rjumplist) do
			if (previous_bufnr == entry.bufnr) then
				goto continue
			end
			if i < current_index then
				file_current_index = file_current_index + 1
			end
			previous_bufnr = entry.bufnr
		    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(entry.bufnr), ":t")

			local icon, hl = MiniIcons.get('file', filename)
			local formatted_line = ' ' .. icon .. ' ' .. filename
			table.insert(lines, formatted_line)
			table.insert(icon_hls, hl)

			::continue::
		end

		vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
		vim.api.nvim_buf_add_highlight(buffer, ns, "Title", 0, 0, -1)
		vim.api.nvim_buf_add_highlight(buffer, ns, "Underlined", 1 + file_current_index, 6, -1)
		vim.api.nvim_buf_add_highlight(buffer, ns, "Special", 1 + file_current_index, 6, -1)

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

-- Quickfix filenames
local qfbuffer = vim.api.nvim_create_buf(false, true)
local nsqfbuffer = vim.api.nvim_create_namespace("qfbuffer")
local scrolloff = 6
function update_quickfix_display()
	local icon_hls = {}
	local qflist = vim.fn.getqflist()

	local title = vim.fn.getqflist({title = 1}).title
	if title == '' then title = 'Quickfix' end
	
	local filenames = { '[' .. table.getn(qflist) .. '] ' .. title }

	local current_entry_index = vim.fn.getqflist({ idx = 0 }).idx

	for i, item in ipairs(qflist) do
		if i > current_entry_index - scrolloff then
			local filename = vim.fn.bufname(item.bufnr)
			if filename ~= "" then
				local modified = vim.fn.fnamemodify(filename, ":t")
				local icon, hl = MiniIcons.get('file', modified)
				local formatted_line = ' ' .. icon .. ' ' .. modified
				table.insert(filenames, formatted_line)
				table.insert(icon_hls, hl)
			end
		end
	end

	vim.api.nvim_buf_set_lines(qfbuffer, 0, -1, false, filenames)

	vim.api.nvim_buf_add_highlight(qfbuffer, nsqfbuffer, "Title", 0, 0, -1)
	for i, hl in ipairs(icon_hls) do
		vim.api.nvim_buf_add_highlight(qfbuffer, nsqfbuffer, hl, i, 1, 2)
	end

	if current_entry_index ~= 0 then
		local line_index = current_entry_index
		if current_entry_index >= scrolloff then line_index = scrolloff end

		vim.api.nvim_buf_add_highlight(qfbuffer, nsqfbuffer, "Special", line_index, 6, -1)
		vim.api.nvim_buf_add_highlight(qfbuffer, nsqfbuffer, "Underlined", line_index, 6, -1)
	end

end

update_quickfix_display()

Snacks.win({
	buf = qfbuffer,
	position = "left",
	enter = false,
})

