-- Indenting
local tab_spaces = 4
vim.opt.tabstop = tab_spaces
vim.opt.shiftwidth = tab_spaces
vim.opt.softtabstop = tab_spaces
vim.opt.smartindent = true

-- Left numbering
vim.opt.number = true
vim.opt.relativenumber = true

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
 -- Close all windows except the top left window
vim.keymap.set("n", "<leader>e", "<c-w><c-t><cmd>:only<cr>")
 -- Move selected
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
 -- No yank
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

 -- Don't use scrolloff on mouse clicks
vim.keymap.set("n", "<LeftMouse>", ":let temp=&so<cr>:let &so=0<cr><LeftMouse>:let &so=temp<cr>", {silent = true})

