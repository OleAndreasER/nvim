return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = "<c-k>",
			hide_numbers = true,
			autochdir = false,
			start_in_insert = true,
			persist_size = true,
			persist_mode = true,
			shell = "powershell",
			auto_scroll = true,
			direction = "horizontal",
			size = 80,
			-- Unused but good float opts
			float_opts = {
				border ='single',
				width = 400,
				height = 60,
				winblend = 0,
				title_pos = "left",
			},
		})
	end,
}
