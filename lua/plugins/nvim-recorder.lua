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
			},
		})
	end,
}
