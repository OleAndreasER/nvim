local M = {}

local tabs = {
	main = {
		spawn_tab = function() end,
	},
	diffview = {
		spawn_tab = function() 
			vim.cmd("DiffviewOpen") 
		end,
	},
	diffview_origin_master = {
		spawn_tab = function() 
			vim.cmd('DiffviewOpen origin/master... --imply-local')
		end,
	},
	http = {
		spawn_tab = function()

			
		end,
	},
}

vim.keymap.set({ "n", "v" }, '<leader>g', function()
	M.toggle_tab('diffview')
end)
vim.keymap.set({ "n", "v" }, '<leader>G', function()
	M.toggle_tab('diffview_origin_master')
end)

local function tab_name(tabnr)
	local ok, name = pcall(vim.api.nvim_tabpage_get_var, tabnr, "tab_name")
	return ok and name or nil
end

local function find(name)
	for _, t in ipairs(vim.api.nvim_list_tabpages()) do
		if tab_name(t) == name then return t end
	end
end

function M.toggle_tab(name)
	local cur = vim.api.nvim_get_current_tabpage()
	local cur_name = tab_name(cur)

	-- Same key while on that tab -> bounce back to main
	if cur_name == name and name ~= "main" then
		name = "main"
	end

	local target = find(name)
	if target then
		vim.api.nvim_set_current_tabpage(target)
		return
	end

	-- Lazy create
	local def = tabs[name] or {}
	if def.spawn_tab then
		def.spawn_tab()
	end
	local new = vim.api.nvim_get_current_tabpage()
	vim.api.nvim_tabpage_set_var(new, "tab_name", name)
end

-- Tag the startup tab as "main"
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local t = vim.api.nvim_get_current_tabpage()
		if not tab_name(t) then
			vim.api.nvim_tabpage_set_var(t, "tab_name", "main")
		end
	end,
})

return M
