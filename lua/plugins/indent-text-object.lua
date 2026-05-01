
vim.pack.add({ "https://github.com/kiyoon/treesitter-indent-object.nvim" })

vim.keymap.set({ "x", "o" }, 'ai', function()
	require("treesitter_indent_object.textobj").select_indent_outer(true)
end)

vim.keymap.set({ "x", "o" }, 'ii', function()
	require("treesitter_indent_object.textobj").select_indent_inner(true)
end)

