return {
	"kwkarlwang/bufjump.nvim",
	config = function()
		vim.api.nvim_set_keymap("n", "(", ":lua require('bufjump').backward()<cr>", { silent=true, noremap=true })
		vim.api.nvim_set_keymap("n", ")", ":lua require('bufjump').forward()<cr>", { silent=true, noremap=true })
		require("bufjump").setup({
			on_success = nil,
		})
	end,
}
