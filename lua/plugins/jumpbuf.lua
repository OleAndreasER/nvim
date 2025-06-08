return {
	"kwkarlwang/bufjump.nvim",
	config = function()
		require("bufjump").setup({
			forward_key = "<C-p>",
			backward_key = "<C-y>",
			on_success = nil,
		})
	end,
}
