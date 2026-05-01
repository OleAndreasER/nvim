
vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter" } })
vim.cmd('TSUpdate')

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"vue",
		"markdown_inline",
		"javascript",
		"typescript",
		"bash",
		"bicep",
		"css",
		"dockerfile",
		"gitignore",
		"html",
		"json",
		"scss",
		"xml",
		"yaml",
		"kulala_http",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
