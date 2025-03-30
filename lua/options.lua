-- Indenting
local tab_spaces = 4
vim.opt.tabstop = tab_spaces
vim.opt.shiftwidth = tab_spaces
vim.opt.softtabstop = tab_spaces
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Left side 
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes:1"

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Wrap
vim.opt.wrap = false

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Stay in the middle of the screen
vim.opt.scrolloff = 9

-- Show in a split search and replace
vim.opt.inccommand = "split"

-- Better colors (?)
vim.opt.termguicolors = true

-- Annoying swapfile stuff
vim.opt.swapfile = false
vim.opt.backup = false

--diagnostic
vim.diagnostic.config({
	virtual_text = { current_line = true },
	signs = false
})

-- Keybinds

vim.g.mapleader = " "
-- Move selected
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Don't use scrolloff on mouse clicks
vim.keymap.set("n", "<LeftMouse>", ":let temp=&so<cr>:let &so=0<cr><LeftMouse>:let &so=temp<cr>", {silent = true})
-- Center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "#", "#zzzv")
vim.keymap.set(
	'c', '<CR>',
	function() return vim.fn.getcmdtype() == '/' and '<CR>zzzv' or '<CR>' end,
	{ expr = true }
)
-- Select all
vim.keymap.set('n', "<C-a>", 'ggVG')
-- LSP Hover
vim.keymap.set('n', '<C-j>', function() vim.lsp.buf.hover() end)
-- Split Window Movement
vim.keymap.set('n', 'ø', '<C-w>l')
vim.keymap.set('n', 'å', '<C-w>h')
-- Run as command
vim.keymap.set('n', '<leader>rl', ':r!<C-r><C-l>')
vim.keymap.set('n', '<leader>ry', ':r!<C-r>"')

