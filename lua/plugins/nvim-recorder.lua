return {
	"chrisgrieser/nvim-recorder",
	keys = {
		{ "q", desc = " Start Recording" },
		{ "Q", desc = " Play Recording" },
	},
	config = function()
		require("recorder").setup({
			mapping = {
				startStopRecording = "q",
				playMacro = "Q",
				switchSlot = nil,
				editMacro = "cq",
				deleteAllMacros = nil,
				yankMacro = nil,
				addBreakPoint = nil,
			},
		})
	end,
}
