vim.pack.add({ 'https://github.com/dmtrKovalenko/fff.nvim', })

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('fff.nvim') end
      require('fff.download').download_or_build_binary()
    end
  end,
})

vim.g.fff = {
  lazy_sync = true,
  debug = { enabled = false, show_scores = false },
}


require('fff').setup({
	prompt_vim_mode = true,
	prompt = '> ',
	title = 'Files',
	keymaps = {
		send_to_quickfix = '<C-f>',
	},
})

-- On selecting file, first switch to main tab.
local original_select = require('fff.picker_ui').select
require('fff.picker_ui').select = function(input)
	require('tab-management').set_tab('main')
	return original_select(input)
end
 
-- Quickfix override
require('fff.picker_ui').send_to_quickfix = function()
	local M = require('fff.picker_ui')
	local function canonicalize_fff_path(relative_path)
		if not relative_path or relative_path == '' then return nil end
		local path = relative_path
		if vim.startswith(path, '\\\\?\\') then path = path:sub(5) end
		if vim.fn.fnamemodify(path, ':p') == path then return path end
		local base = require('fff.conf').get().base_path
		if not base or base == '' then return path end
		return vim.fs.normalize(base .. '/' .. path)
	end
	local function resolve_item_path(item) return item and canonicalize_fff_path(item.relative_path) or nil end

	if not M.state.active then return end
	local qf_list = {}
	if M.state.mode == 'grep' then
		local has_selections = next(M.state.selected_items) ~= nil
		if has_selections then
			for _, item in pairs(M.state.selected_items) do
				local abs = resolve_item_path(item)
				if abs then
					table.insert(qf_list, {
						filename = abs,
						lnum = item.line_number or 1,
						col = (item.col or 0) + 1,
						text = item.line_content or vim.fn.fnamemodify(abs, ':.'),
					})
				end
			end
		else
			local grep = require('fff.grep')
			local exhaustive_config = vim.tbl_extend('force', M.state.grep_config or {}, { max_matches_per_file = 0 })
			local exhaustive = grep.search(M.state.query, 0, 10000, exhaustive_config, M.state.grep_mode)
			local all_items = exhaustive and exhaustive.items or {}
			if #all_items == 0 then
				vim.notify('No matches to send to quickfix', vim.log.levels.WARN)
				return
			end
			for _, item in ipairs(all_items) do
				local abs = resolve_item_path(item)
				if abs then
					table.insert(qf_list, {
						filename = abs,
						lnum = item.line_number or 1,
						col = (item.col or 0) + 1,
						text = item.line_content or vim.fn.fnamemodify(abs, ':.'),
					})
				end
			end
		end
	else
		local paths = {}
		if next(M.state.selected_files) then
			for relative_path, _ in pairs(M.state.selected_files) do
				table.insert(paths, canonicalize_fff_path(relative_path))
			end
		else
			for _, item in ipairs(M.state.filtered_items) do
				local abs = resolve_item_path(item)
				if abs then table.insert(paths, abs) end
			end
		end
		if #paths == 0 then
			vim.notify('No files to send to quickfix', vim.log.levels.WARN)
			return
		end
		for _, path in ipairs(paths) do
			table.insert(qf_list, {
				filename = path,
				lnum = 1,
				col = 1,
				text = vim.fn.fnamemodify(path, ':.'),
			})
		end
	end

	-- Override
	
	local query = M.state.query
	M.close()

	vim.fn.setqflist({}, ' ', {
		title = query or 'FFF',
		items = qf_list
	})
	require('quick-fix').update_displays()
end

vim.keymap.set('n', '<leader>f', function()
	require('fff').find_files({ 
		layout = {
			height = 1,
			width = 0.76,
			prompt_position = 'bottom',
			preview_position = 'bottom',
			preview_size = 0.7,
			flex = { size = 130, wrap = 'top' },
			show_scrollbar = false,
			path_shorten_strategy = 'middle_number',
			anchor = 'top',
		},
	})
end)
vim.keymap.set('n', '<leader>s', function()
	require('fff').live_grep({
		layout = {
			height = 1,
			width = 0.76,
			prompt_position = 'top',
			preview_position = 'top',
			preview_size = 0.5,
			flex = { size = 130, wrap = 'top' },
			show_scrollbar = false,
			path_shorten_strategy = 'middle_number',
			anchor = 'top',
		}
	}) 
end)
-- Grep current word
vim.keymap.set('n', '<leader>S', function()
	require('fff').live_grep({
		query = vim.fn.expand("<cword>"),
		layout = {
			height = 1,
			width = 0.76,
			prompt_position = 'top',
			preview_position = 'top',
			preview_size = 0.5,
			flex = { size = 130, wrap = 'top' },
			show_scrollbar = false,
			path_shorten_strategy = 'middle_number',
			anchor = 'top',
		}
	}) 
end)
