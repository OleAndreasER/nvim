local M = {}

local previous_tab = nil

local tabs = {
	main = {
		spawn_tab = function() end,
	},
	diffview = {
		spawn_tab = function() 
			vim.cmd("DiffviewOpen") 
		end,
	},
	terminals = {
		spawn_tab = function()
			vim.cmd('tabnew')
			vim.cmd('term')
		end,
	},
	http = {
		spawn_tab = function()
			vim.cmd('tabnew')
			local dir = vim.fn.expand("~/http")
			vim.fn.mkdir(dir, "p")
			vim.cmd("edit " .. vim.fn.fnameescape(dir .. "/main.http"))
		end,
	},
	diffview_origin_master = {
		spawn_tab = function() 
			vim.cmd('DiffviewOpen origin/master... --imply-local')
		end,
	},
}


vim.keymap.set({ 'n', 't', 'i' }, '<leader>g', function()
	M.toggle_tab('diffview')
end)
vim.keymap.set({ 'n', 't', 'i' }, '<c-8>', function()
	M.toggle_tab('terminals')
end)
vim.keymap.set({ 'n', 't', 'i' }, '<c-,>', function()
	M.toggle_tab('http')
end)
vim.keymap.set({ 'n', 't', 'i' }, '<c-.>', function()
	M.toggle_tab('main')
end)

vim.keymap.set({ 'n', 't', 'i' }, '<leader>G', function()
	M.toggle_tab('diffview_origin_master')
end)

local function tab_name(tab_number)
	local ok, name = pcall(vim.api.nvim_tabpage_get_var, tab_number, "tab_name")
	return ok and name or nil
end

local function find_tabpage(name)
	for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		if tab_name(tabpage) == name then return tabpage end
	end
end

function M.toggle_tab(name)
	local current_tab_name = tab_name(vim.api.nvim_get_current_tabpage())

	-- If already on the tab, go to previous tab.
	if current_tab_name == name then
		if not previous_tab then return end
		if previous_tab == name then return end
		name = previous_tab
	end

	local target = find_tabpage(name)
	if target then
		vim.api.nvim_set_current_tabpage(target)
		return
	end

	-- Spawn tab if not exists.
	local tab = tabs[name] or {}
	if tab.spawn_tab then
		tab.spawn_tab()
	end
	vim.api.nvim_tabpage_set_var(vim.api.nvim_get_current_tabpage(), "tab_name", name)
end

-- Tag the initial tab as "main"
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local initial_tabpage = vim.api.nvim_get_current_tabpage()
		if not tab_name(initial_tabpage) then
			vim.api.nvim_tabpage_set_var(initial_tabpage, "tab_name", "main")
		end
	end,
})

-- Remember previous tab
vim.api.nvim_create_autocmd("TabLeave", {
	callback = function()
		local name = tab_name(vim.api.nvim_get_current_tabpage())
		if name then previous_tab = name end
	end,
})

return M
