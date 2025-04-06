return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require('tiny-inline-diagnostic').setup({
			preset = 'minimal',
			options = {
				severity = {
					vim.diagnostic.severity.ERROR,
					vim.diagnostic.severity.WARN,
				},
			}
		})
        vim.diagnostic.config({
			virtual_text = false,
			signs = false,
		})
    end
}
