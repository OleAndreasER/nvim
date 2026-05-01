require("options")
require('quick-fix').setup()
require("neovide")
require("tab-management")

-- require /lua/plugins/*.lua
for _, f in ipairs(vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", false, true)) do
	local mod = "plugins." .. vim.fn.fnamemodify(f, ":t:r")
	local ok, err = pcall(require, mod)
	if not ok then
		vim.notify("Failed to load " .. mod .. ": " .. err, vim.log.levels.ERROR)
	end
end
require("sidebar")
require("custom-color-scheme").colorscheme()
vim.keymap.set("n", "<C-j>", "<C-w>j")
