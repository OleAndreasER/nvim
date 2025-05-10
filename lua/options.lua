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


-- Keymaps
--
-- Available: 
-- s
-- ;
-- ' " (taken but can be different)
-- m (taken but can be different)
-- H
-- L
-- X

vim.g.mapleader = " "
-- Don't use scrolloff on mouse clicks
vim.keymap.set("n", "<LeftMouse>", ":let temp=&so<cr>:let &so=0<cr><LeftMouse>:let &so=temp<cr>", { silent = true })
-- Center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "#", "#zzzv")
vim.keymap.set("n", "G", "Gzzzv")

vim.keymap.set(
	'c', '<cr>',
	function() return vim.fn.getcmdtype() == '/' and '<cr>zzzv' or '<cr>' end,
	{ expr = true }
)
-- Select all
vim.keymap.set('n', "<C-a>", 'ggVG')
-- LSP Hover
vim.keymap.set('n', '<C-j>', function() vim.lsp.buf.hover() end)
-- Split Window Movement
vim.keymap.set('n', 'ø', '<C-w>l')
vim.keymap.set('n', 'å', '<C-w>h')
vim.keymap.set('n', '<C-g>', '<C-w>k')
--vim.keymap.set('n', '<C-b>', '<C-w>j')
-- Write
vim.keymap.set({'v', 'n'}, '<leader>w', ':w<cr>', { silent = true })
vim.keymap.set({'v', 'n'}, '<leader>W', ':wa<cr>', { silent = true })
vim.keymap.set({'v', 'n'}, '<leader>Q', ':wqa!<cr>', { silent = true })
vim.keymap.set({'v', 'n'}, '<leader>q', ':q!<cr>', { silent = true })
-- Highlights
vim.keymap.set('n', 'dh', ':noh<cr>', { silent = true })
-- Macro commands
vim.keymap.set('n', '<leader>pc', 'oconsole.log( `<esc>pA`, <esc>pA );<esc>0')
-- Diagnostics
vim.keymap.set({'v','n'}, '<leader>e', function ()
	vim.diagnostic.setqflist({
		open = false,
		severity = vim.diagnostic.severity.ERROR,
	})
	update_quickfix_display()
end, { silent = true } )
