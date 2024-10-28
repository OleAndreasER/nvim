-- Tabs
local tab_spaces = 4
vim.opt.tabstop = tab_spaces
vim.opt.shiftwidth = tab_spaces
vim.opt.softtabstop = tab_spaces

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
vim.opt.scrolloff = 999

-- Show in a split search and replace
vim.opt.inccommand = "split"

-- Better colors (?)
vim.opt.termguicolors = true

-- Keybinds
vim.g.mapleader = " "

-- Autocmd
--vim.api.nvim_create_autocmd("BufWritePost", {
--	callback = function ()
--		vim.lsp.buf.format()
--	end
--})

