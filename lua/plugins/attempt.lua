return {
	"m-demare/attempt.nvim",
	config = function()
		local attempt = require("attempt")
		attempt.setup({
			ext_options = { "", "js", "ts" },
			format_opts = { [""] = "Note" },
		})
		vim.keymap.set("n", "<leader>a", attempt.new_input_ext)
	end,
}
