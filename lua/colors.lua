vim.api.nvim_set_hl(0, "Normal", {
	fg = "",
	bg = "#23272e",
})

vim.api.nvim_set_hl(0, "FloatBorder", {
	link = "Normal"
})
vim.api.nvim_set_hl(0, "NormalFloat", {
	link = "Normal"
})

vim.api.nvim_set_hl(0, "TelescopeNormal", {
	bg = "#262a32"
})
vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "TelescopeNormal" })
vim.api.nvim_set_hl(0, "TelescopeMatching", { link = "TelescopeNormal" })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "TelescopeNormal" })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { link = "TelescopeNormal" })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { link = "TelescopeNormal" })

