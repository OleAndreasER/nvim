return {
	'fnune/recall.nvim',
	config = function ()
		require("recall").setup({
			sign = "",
			sign_highlight = '',
			telescope = {
				autoload = true,
				mappings = {
					unmark_selected_entry = {
						normal = "d",
						insert = "",
					},
				},
			},
			wshada = vim.fn.has("nvim-0.10") == 0,
		})
		vim.keymap.set("n", "m", ":RecallToggle<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "dm", ":RecallClear<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "'", ":RecallNext<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", '"', ":RecallPrevious<CR>", { noremap = true, silent = true })
	end
}
