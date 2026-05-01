
vim.pack.add({ "https://github.com/mistweaverco/kulala.nvim" })

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

-- Set filetype in kulala ui buffers.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*.kulala_ui",
	callback = function(args)
		local filetype = args.match:gsub("%.kulala_ui$", "")
		vim.api.nvim_set_option_value("filetype", filetype, { buf = args.buf })
		vim.api.nvim_set_option_value("buftype", "nofile", { buf = args.buf })
		vim.api.nvim_set_option_value("bufhidden", "hide", { buf = args.buf })
		vim.api.nvim_set_option_value("swapfile", false, { buf = args.buf })
	end,
})

-- Keymaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = "http",
	callback = function(args)
		local buf = args.buf
		vim.keymap.set("n", "<c-r>", require('kulala').run, { buffer = buf, silent = true, })
	end,
})
