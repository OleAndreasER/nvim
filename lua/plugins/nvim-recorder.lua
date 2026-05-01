
vim.pack.add({ "https://github.com/chrisgrieser/nvim-recorder" })

require("recorder").setup({
	mapping = {
		startStopRecording = "q",
		playMacro = "Q",
		switchSlot = nil,
		editMacro = "cq",
		deleteAllMacros = "<leader>Dq",
		yankMacro = nil,
		addBreakPoint = nil,
	},
})

