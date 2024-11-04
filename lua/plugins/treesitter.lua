return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
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
				"yaml"
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Leader>ss",
					scope_incremental = "<Leader>sc",
					node_incremental = "<Leader>si",
					node_decremental = "<Leader>sd",
				}
			}
		}
	end,
}
