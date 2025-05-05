return {
	'dmmulroy/tsc.nvim',
	config = function()
		require('tsc').setup({
			auto_open_qflist = false,
			auto_close_qflist = false,
			auto_focus_qflist = false,
			auto_start_watch_mode = false,
			use_trouble_qflist = false,
			use_diagnostics = false,
			run_as_monorepo = false,
			enable_progress_notifications = true,
			enable_error_notifications = true,
			hide_progress_notifications_from_history = true,
			spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
			pretty_errors = true,
		})
		vim.keymap.set({ 'n', 'v' }, '<leader>E', '<cmd>TSCOpen<cr><cmd>lua update_quickfix_display()<cr>')
	end,
}
