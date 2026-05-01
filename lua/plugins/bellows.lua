
vim.pack.add({ { src = "https://github.com/skyppex/bellows.nvim" } })

require("bellows").setup({
	line_count = true,
	array_count_threshold = 3,
	array_count_threshold_folded = 0,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function(args)
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
		if filetype ~= "json" then return end

		local function toggle(condition, false_func, true_func)
			return function()
				if condition() then
					true_func()
				else
					false_func()
				end
			end
		end

		vim.keymap.set( "n", "<leader>o",
			toggle(
				require('bellows').is_on_closed_fold,
				require('bellows').fold_closest_block,
				require('bellows').unfold_closest_block
			),
			{ buffer = args.buf, silent = true, }
		)

		vim.keymap.set( "n", "<leader>i",
			toggle(
				require('bellows').is_on_closed_fold,
				require('bellows').fold_closest_block_recursive,
				require('bellows').unfold_closest_block_recursive
			),
			{ buffer = args.buf, silent = true, }
		)

		vim.keymap.set( "n", "m",
			toggle(
				require('bellows').is_pinned,
				require('bellows').pin,
				require('bellows').unpin
			),
			{ buffer = args.buf, silent = true, }
		)

		vim.keymap.set("n", "dm", require('bellows').clear_pins, { buffer = args.buf, silent = true })
	end,
})

