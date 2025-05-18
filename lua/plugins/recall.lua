return {
	"fnune/recall.nvim",
	config = function()
		require("recall").setup({
			sign = "",
			sign_highlight = "",
			wshada = false,
		})
		vim.keymap.set("n", "m", ":RecallToggle<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "dm", ":RecallClear<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "'", ":RecallNext<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", '"', ":RecallPrevious<cr>", { noremap = true, silent = true })
	end,
}
