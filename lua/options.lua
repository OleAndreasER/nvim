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
vim.opt.signcolumn = "yes"

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
-- Select all
vim.keymap.set('n', "<C-a>", 'ggVG')
-- Indent many lines
vim.keymap.set('n', '==', '100==')
-- LSP Hover
vim.keymap.set('n', '<C-j>', function() vim.lsp.buf.hover() end)
-- Split Window Movement
vim.keymap.set('n', 'ø', '<C-w>l')
vim.keymap.set('n', 'å', '<C-w>h')
-- Indent on paste
vim.cmd('nnoremap p p=`]')

