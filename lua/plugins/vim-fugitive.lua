
vim.pack.add({ { src = "https://github.com/tpope/vim-fugitive" } })

vim.keymap.set("n", "<leader>c", [[:G commit -m ""<left>]])
vim.keymap.set("n", "H", [[:G ]])

