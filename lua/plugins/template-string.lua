
vim.pack.add({ { src = "https://github.com/axelvc/template-string.nvim" } })

require('template-string').setup({
	filetypes = { 'html', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue', 'svelte', 'python', 'cs' },
	jsx_brackets = true,
	remove_template_string = false,
	restore_quotes = {
		normal = [[']],
		jsx = [["]],
	},
})
