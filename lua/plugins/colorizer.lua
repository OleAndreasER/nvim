return {
	"catgoose/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"css",
			"scss",
		})
	end,
}
