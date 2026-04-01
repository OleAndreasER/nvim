local M = {}

-- Signs
vim.api.nvim_create_namespace("qf_signs")
vim.fn.sign_define("QFSign", {
  text = "-",
  texthl = "Normal",
})
local function update_signs()
	-- clear existing signs
	vim.fn.sign_unplace("qf_signs")

	local qf = vim.fn.getqflist()
	if #qf == 0 then return end

	for i, item in ipairs(qf) do
		if item.bufnr and item.lnum then
			vim.fn.sign_place(
				i,                 -- unique id
				"qf_signs",        -- group
				"QFSign",          -- sign name
				item.bufnr,
				{ lnum = item.lnum, priority = 10 }
			)
		end
	end
end

function M.update_displays(title_override)
	update_quickfix_display(title_override)
	update_signs()
end

-- Navigate by offset. 
-- Wrap unless playing/recording macro.
-- Wrapping is good for browsing. It's bad for performing a macro on all entries.
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
	M.update_displays()
end

-- Clear quickfix and remove from display.
function M.clear()
	if #vim.fn.getqflist() == 0 then return end
	vim.cmd('silent! cexpr []')
	M.update_displays('') -- Empty title makes display go away
end

-- Remove entries in `bufnr` and go to an entry before the removed entries entries.
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
	vim.cmd('normal! zz')
	M.update_displays()
end

-- After creating a new quickfix, this can be used to go to a reasonable initial entry.
function M.go_to_initial_entry()
	if #vim.fn.getqflist() == 0 then return end

	local bufnr = vim.api.nvim_get_current_buf()
	local linenr = vim.api.nvim_win_get_cursor(0)[1]

	-- From preferred entry to least preferred
	-- 1. Entry closest after current line in current buffer
	-- 2. Entry closest before current line in current buffer
	-- 3. First entry

	local closest_before = nil
	local closest_idx_before = nil
	local closest_after = nil
	local closest_idx_after = nil
	for i, item in ipairs(vim.fn.getqflist()) do
		if item.bufnr == bufnr then
			if item.lnum < linenr then
				-- Before
				if closest_before == nil or closest_before < item.lnum then
					closest_before = item.lnum
					closest_idx_before = i
				end
			else
				-- After
				if closest_after == nil or closest_after > item.lnum then
					closest_after = item.lnum
					closest_idx_after = i
				end
			end
		end
	end

	if closest_idx_after ~= nil then
		-- 1.
		vim.cmd('silent! cc ' .. closest_idx_after)
	elseif closest_idx_before ~= nil then
		-- 2.
		vim.cmd('silent! cc ' .. closest_idx_before)
	else
		-- 3.
		vim.cmd('silent! cfirst')
	end

	vim.cmd('normal! zz')
	M.update_displays()
end

function M.add_search_to_quickfix()
	vim.cmd('silent! vimgrepadd //gj %')
	vim.fn.setqflist({}, 'a', {
		title = "Quickfix",
	})
	M.update_displays()
end

function M.add_cursor_to_quickfix()
	local cursor_position = vim.api.nvim_win_get_cursor(0)
	local bufnr = vim.api.nvim_get_current_buf()
	vim.fn.setqflist({}, 'a', {
		title = "Quickfix",
		items = {
			{
				bufnr = bufnr,
				lnum = cursor_position[1],
				col = cursor_position[2] + 1, -- quickfix is 1-based
			},
		},
	})
	M.update_displays()
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

	vim.api.nvim_create_user_command('QfAddFromSearch', function(opts)
		M.add_search_to_quickfix()
	end, {})

	vim.api.nvim_create_user_command('QfAddCursor', function(opts)
		M.add_cursor_to_quickfix()
	end, {})

	vim.keymap.set({ "n", "v" }, "<C-g>", "<cmd>QfNext<cr>")
	vim.keymap.set({ "n", "v" }, "<C-e>", "<cmd>QfPrevious<cr>")
	vim.keymap.set({ "n" }, "dq", "<cmd>QfClear<cr>")
	vim.keymap.set({ "n" }, "m", '<cmd>QfAddCursor<cr>' )
	vim.keymap.set({ "n" }, "<leader>/", "<cmd>QfAddFromSearch<cr>")
end

return M
