return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	config = function () 
		require('kulala').setup({
			default_env = "local",
			ui = {
				winbar = false,
				show_request_summary = false,
				disable_news_popup = true,
				win_opts = {
					wo = { foldmethod = "manual" },
				},
				max_response_size = 104857600,
			},
			global_keymaps = false,
			kulala_keymaps = false,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "http",
			callback = function(args)
				local buf = args.buf
				vim.keymap.set("n", "<c-r>", require('kulala').run, { buffer = buf, silent = true, })
			end,
		})
	end,
}
