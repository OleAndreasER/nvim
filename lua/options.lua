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

vim.keymap.set("c", "<cr>", function()
	return vim.fn.getcmdtype() == "/" and "<cr>zzzv" or "<cr>"
end, { expr = true })
-- LSP Hover
vim.keymap.set("n", "<C-d>", function()
	vim.lsp.buf.hover()
end)
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
-- Diagnostics
vim.keymap.set("n", "<c-d>", function() vim.diagnostic.jump({
	count = 1,
	float = false,
	severity = vim.diagnostic.severity.ERROR 
}) end)
-- Jump to next buffer with an error.
vim.keymap.set("n", "<leader>e", function ()
	local buffers = vim.api.nvim_list_bufs()
	local current_buffer = vim.api.nvim_get_current_buf()

	local current_index = 1
	for i, buffer in ipairs(buffers) do
		if buffer == current_buffer then
			current_index = i
			break
		end
	end

	-- From current to the end.
	for i = current_index + 1, #buffers do
		if #vim.diagnostic.get(buffers[i], { severity = vim.diagnostic.severity.ERROR }) > 0 then
			vim.api.nvim_set_current_buf(buffers[i])
			return
		end
	end

	-- From first to current.
	for i = 1, current_index - 1 do
		if #vim.diagnostic.get(buffers[i], { severity = vim.diagnostic.severity.ERROR }) > 0 then
			vim.api.nvim_set_current_buf(buffers[i])
			return
		end
	end

	print("No other buffers with errors")
end )

-- Qflist
vim.keymap.set({ "n", "v" }, "<C-'>", "<cmd>cnext<cr><cmd>lua update_quickfix_display()<cr>")
vim.keymap.set({ "n", "v" }, "<C-x>", "<cmd>cprevious<cr><cmd>lua update_quickfix_display()<cr>")
vim.keymap.set({ "n" }, "dq", ":cexpr []<cr><cmd>lua update_quickfix_display()<cr>", { silent = true })
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


