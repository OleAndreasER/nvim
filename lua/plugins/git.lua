return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>g", "<cmd>Ge :<cr>5j", { silent = true })

			vim.api.nvim_create_augroup("FugitiveRemoveBinds", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = "FugitiveRemoveBinds",
				pattern = "fugitive",
				callback = function()
					vim.api.nvim_buf_del_keymap(0, "n", "(")
					vim.api.nvim_buf_del_keymap(0, "n", ")")
				end,
			})

		end,
	},
}
