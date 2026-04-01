local M = {}

function M.navigate(offset)
	if #vim.fn.getqflist() == 0 then return end
	local is_recording_macro = require("recorder").recordingStatus() ~= '' 
	local is_playing_macro = vim.fn.reg_executing() ~= '' 

	if is_recording_macro or is_playing_macro then
		-- No wrap
		local idx = vim.fn.getqflist({ idx = 0 }).idx
		local new_idx = idx + offset
		vim.cmd('silent! cc ' .. new_idx)
	else
		-- Wrap
		local idx = vim.fn.getqflist({ idx = 0 }).idx
		local new_idx = ((idx - 1 + offset) % #vim.fn.getqflist() + 1)
		vim.cmd('silent! cc ' .. new_idx)
	end
	vim.cmd('normal! zz')
	update_quickfix_display()
end

function M.go_to_first()
	if #vim.fn.getqflist() == 0 then return end
	vim.cmd('silent! cfirst')
	vim.cmd('normal! zz')
	update_quickfix_display()
end

function M.clear()
	if #vim.fn.getqflist() == 0 then return end
	vim.cmd('silent! cexpr []')
	update_quickfix_display('') -- Empty title makes display go away
end

function M.remove_buffer_entries(bufnr)
	if #vim.fn.getqflist() == 0 then return end

	local idx = vim.fn.getqflist({ idx = 0 }).idx
	local new_idx = idx
	local filtered = {}
	for i, item in ipairs(vim.fn.getqflist()) do
		if item.bufnr ~= bufnr then
			table.insert(filtered, item)
		elseif i < idx then
			new_idx = new_idx - 1
		end
	end

	vim.fn.setqflist({}, 'r', { items = filtered })
	vim.cmd('silent! cc ' .. new_idx)
	update_quickfix_display()
end

function M.setup()

	vim.api.nvim_create_user_command('QfNext', function(opts)
		M.navigate(1)
	end, {})

	vim.api.nvim_create_user_command('QfPrevious', function(opts)
		M.navigate(-1)
	end, {})

	vim.api.nvim_create_user_command('QfClear', function(opts)
		M.clear()
	end, {})

end

return M
