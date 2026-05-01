
vim.pack.add({ {
	src = 'https://github.com/nvim-treesitter/nvim-treesitter',
	version = 'main',
} })

require('nvim-treesitter').setup({
	install_dir = vim.fn.stdpath('data') .. '/site',
})

require('nvim-treesitter').install({
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
	"http"
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { '*' },
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then return end
		if not vim.treesitter.language.add(lang) then
			local available = vim.g.ts_available or require('nvim-treesitter').get_available()
			if not vim.g.ts_available then
				vim.g.ts_available = available
			end
			if vim.tbl_contains(available, lang) then
				require('nvim-treesitter').install(lang)
			end
		end
		if vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

