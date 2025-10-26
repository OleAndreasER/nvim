-- Indenting
local tab_spaces = 4
vim.opt.tabstop = tab_spaces
vim.opt.shiftwidth = tab_spaces
vim.opt.softtabstop = tab_spaces
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes:1"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 9
vim.opt.inccommand = "split"
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.shell = 'powershell'
vim.opt.cmdheight = 0
vim.opt.laststatus = 0


-- Keymaps
--
-- Available:
-- s
-- H
-- L
-- X

vim.g.mapleader = " "
-- Don't use scrolloff on mouse clicks
vim.keymap.set("n", "<LeftMouse>", ":let temp=&so<cr>:let &so=0<cr><LeftMouse>:let &so=temp<cr>", { silent = true })
-- Center
vim.keymap.set("n", "<C-n>", "<C-d>zz")
vim.keymap.set("n", "<C-w>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "#", "#zzzv")
vim.keymap.set("n", "G", "Gzzzv")
vim.keymap.set({"n", "v"}, "<c-u>", "<c-u>zz")
vim.keymap.set({"n", "v"}, "<c-d>", "<c-d>zz")

vim.keymap.set("c", "<cr>", function()
	return vim.fn.getcmdtype() == "/" and "<cr>zzzv" or "<cr>"
end, { expr = true })
-- LSP Hover
-- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
-- Split Window Movement
vim.keymap.set("n", "ø", "<C-w>l")
vim.keymap.set("n", "å", "<C-w>h")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set({ "v", "n" }, "<leader>v", ":vs<cr>", { silent = true })
--vim.keymap.set('n', '<C-b>', '<C-w>j')
-- Write
vim.keymap.set({ "v", "n" }, "<leader>w", ":w<cr>", { silent = true })
vim.keymap.set({ "v", "n" }, "<leader>W", ":wa<cr>", { silent = true })
vim.keymap.set({ "v", "n" }, "<leader>Q", ":wqa!<cr>", { silent = true })
vim.keymap.set({ "v", "n" }, "<leader>q", ":q!<cr>", { silent = true })
vim.keymap.set({ "v", "n" }, "<leader>x", "<cmd>wa<cr><cmd>qa<cr>", { silent = true })
-- Highlights
vim.keymap.set("n", "dh", ":noh<cr>", { silent = true })
-- Macro commands
vim.keymap.set("n", "<leader>pc", "oconsole.log( `<esc>pA`, <esc>pA );<esc>0")

-- Qflist
vim.keymap.set({ "n", "v" }, "<C-'>", "<cmd>cnext<cr><cmd>lua update_quickfix_display()<cr>zz")
vim.keymap.set({ "n", "v" }, "<C-x>", "<cmd>cprevious<cr><cmd>lua update_quickfix_display()<cr>zz")
vim.keymap.set({ "n" }, "dq", [[:cexpr []<cr><cmd>lua update_quickfix_display("")<cr>]], { silent = true })
--Buffer g "textobject"
vim.keymap.set("n", "yag", ":%y<cr>", { silent = true })
vim.keymap.set("n", "cag", ":%d<cr>i", { silent = true })
vim.keymap.set("n", "dag", ":%d<cr>", { silent = true })
vim.keymap.set("n", "vag", "ggVG", { silent = true })
-- Terminal
vim.keymap.set('t', '<esc>', "<C-\\><C-n>", { silent = true })
-- Ctrl-V paste
vim.keymap.set('i' , '<C-m>', '<C-r>+')
vim.keymap.set("c", '<C-m>', '<C-r>+')


--
-- Diagnostics
--
-- Jump to next error in buffer
vim.keymap.set("n", "<c-t>", function() 
	vim.diagnostic.jump({
		count = 1,
		float = false,
		severity = vim.diagnostic.severity.ERROR 
	}) 
	vim.cmd("normal! zz")
end)
-- Jump to next buffer with an error.
vim.keymap.set("n", "<leader>e", function ()
	local diagnostics = vim.diagnostic.get(nil, {
		severity = vim.diagnostic.severity.ERROR,
	})

	-- Gather unique bufnrs
	local last_diagnostic_of_buffer = {}
	for _, diagnostic in ipairs(diagnostics) do
		last_diagnostic_of_buffer[diagnostic.bufnr] = diagnostic
	end

	local current_buffer = vim.api.nvim_get_current_buf()
	local smallest_after = math.huge
	local smallest_before = math.huge
	local current_buffer_has_errors = false
	for bufnr, _ in pairs(last_diagnostic_of_buffer) do
		if (bufnr ~= current_buffer) then
			if (bufnr > current_buffer) then
				smallest_after = math.min(smallest_after, bufnr)
			else
				smallest_before = math.min(smallest_before, bufnr)
			end
		else
			current_buffer_has_errors = true
		end
	end

	-- Next after current.
	if (smallest_after ~= math.huge) then
		vim.api.nvim_set_current_buf(smallest_after)
		vim.api.nvim_win_set_cursor(0, {
			last_diagnostic_of_buffer[smallest_after].lnum + 1,
			last_diagnostic_of_buffer[smallest_after].col,
		})

	-- First before current (wrapping)
	elseif (smallest_before ~= math.huge) then
		vim.api.nvim_set_current_buf(smallest_before)
		vim.api.nvim_win_set_cursor(0, {
			last_diagnostic_of_buffer[smallest_before].lnum + 1,
			last_diagnostic_of_buffer[smallest_before].col,
		})
		vim.cmd("normal! zz")

	elseif (current_buffer_has_errors) then
		print("Current buffer is the only one with errors.")

	else
		print("Found no errors.")
	end
end )
