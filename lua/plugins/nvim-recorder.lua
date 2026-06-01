
vim.pack.add({ "https://github.com/chrisgrieser/nvim-recorder" })

require("recorder").setup({
	mapping = {
		startStopRecording = [[']],
		playMacro = [["]],
		switchSlot = nil,
		editMacro = "cq",
		deleteAllMacros = "<leader>Dq",
		yankMacro = nil,
		addBreakPoint = nil,
	},
})

