return {
	"kwkarlwang/bufjump.nvim",
	config = function()
		require("bufjump").setup({
			forward_key = "<C-n>",
			backward_key = "<C-p>",
			on_success = nil,
		})
	end,
}
