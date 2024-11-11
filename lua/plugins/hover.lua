return {
	"lewis6991/hover.nvim",
	config = function()
		require("hover").setup({
			init = function()
				require("hover.providers.lsp")
			end,
			preview_opts = {
				border = 'single'
			},
			preview_window = false,
			title = true,
			mouse_providers = { 'LSP' },
			mouse_delay = 200
		})

		-- Setup keymaps
		vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })

		-- Mouse support
		vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
		vim.o.mousemoveevent = true
	end
}
