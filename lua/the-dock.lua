-- Recent buffers
local recent_files_buffer = vim.api.nvim_create_buf(false, true)
vim.b[recent_files_buffer].should_not_be_enterable = true
vim.api.nvim_buf_set_name(recent_files_buffer, "Recent files")
local ns = vim.api.nvim_create_namespace("recent-buffers")

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if vim.b[buf].should_not_be_enterable then
			return
		end

		local jumplist = vim.fn.getjumplist()
		local rjumplist = {}
		for i = #jumplist[1], 1, -1 do
			table.insert(rjumplist, jumplist[1][i])
		end

		local lines = {}

		local icon_hls = {}

		local current_index = #jumplist[1] - jumplist[2]

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
			if previous_bufnr == entry.bufnr then
				goto continue
			end
			if i < current_index then
				file_current_index = file_current_index + 1
			end
			previous_bufnr = entry.bufnr

			local path = vim.api.nvim_buf_get_name(entry.bufnr)
			local filename = ""
			if path:find("^fugitive") then
				filename = "Git status"
			else
				filename = vim.fn.fnamemodify(path, ":t")
			end

			local icon, hl = MiniIcons.get("file", filename)
			local filename_line = " " .. icon .. " " .. filename
			table.insert(icon_hls, hl)
			table.insert(lines, filename_line)

			::continue::
		end

		vim.api.nvim_buf_set_lines(recent_files_buffer, 0, -1, false, lines)
		vim.api.nvim_buf_add_highlight(recent_files_buffer, ns, "Underlined", file_current_index, 6, -1)
		vim.api.nvim_buf_add_highlight(recent_files_buffer, ns, "Special", file_current_index, 6, -1)

		for i, hl in ipairs(icon_hls) do
			vim.api.nvim_buf_add_highlight(recent_files_buffer, ns, hl, i - 1, 1, 2)
		end
	end,
})

-- Quickfix filenames
local qf_buffer = vim.api.nvim_create_buf(false, true)
vim.b[qf_buffer].should_not_be_enterable = true
vim.api.nvim_buf_set_name(qf_buffer, "Quickfix")
local nsqfbuffer = vim.api.nvim_create_namespace("qfbuffer")

local scrolloff = 20
function update_quickfix_display()
	local icon_hls = {}
	local qflist = vim.fn.getqflist()

	local title = vim.fn.getqflist({ title = 1 }).title
	if title == "" then
		title = "Quickfix"
	end

	vim.api.nvim_buf_set_name(qf_buffer, "[" .. table.getn(qflist) .. "] " .. title )

	local filenames = { }

	local current_entry_index = vim.fn.getqflist({ idx = 0 }).idx

	for i, item in ipairs(qflist) do
		if i > current_entry_index - scrolloff then
			local filename = vim.fn.bufname(item.bufnr)
			if filename ~= "" then
				local modified = vim.fn.fnamemodify(filename, ":t")
				local icon, hl = MiniIcons.get("file", modified)
				local formatted_line = " " .. icon .. " " .. modified
				table.insert(filenames, formatted_line)
				table.insert(icon_hls, hl)
			end
		end
	end

	vim.api.nvim_buf_set_lines(qf_buffer, 0, -1, false, filenames)

	for i, hl in ipairs(icon_hls) do
		vim.api.nvim_buf_add_highlight(qf_buffer, nsqfbuffer, hl, i - 1, 1, 2)
	end

	if current_entry_index ~= 0 then
		local line_index = current_entry_index
		if current_entry_index >= scrolloff then
			line_index = scrolloff
		end

		vim.api.nvim_buf_add_highlight(qf_buffer, nsqfbuffer, "Special", line_index - 1, 6, -1)
		vim.api.nvim_buf_add_highlight(qf_buffer, nsqfbuffer, "Underlined", line_index - 1, 6, -1)
	end
end

update_quickfix_display()

Snacks.win({
	buf = recent_files_buffer,
	position = "left",
	width = 0.12,
	enter = false,
})

Snacks.win({
	buf = qf_buffer,
	position = "left",
	width = 0.12,
	enter = false,
})

vim.schedule(function()
	vim.cmd("wincmd l")
end)

-- Don't allow sidebar to be entered
vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if vim.b[buf].should_not_be_enterable then
			vim.schedule(function()
				vim.cmd("wincmd l")
			end)
		end
	end
})

