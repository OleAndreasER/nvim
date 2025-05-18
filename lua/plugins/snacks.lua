local exclude = {
	"node_modules/",
	"dist/",
	".next/",
	".vite/",
	".git/",
	".gitlab/",
	"build/",
	"target/",
	"package-lock.json",
	"pnpm-lock.yaml",
	"yarn.lock",
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = false },
		input = { enabled = false },
		picker = {
			layout = {
				preset = 'dropdown_main_preview',
				cycle = false,
			},
			layouts = {
				dropdown_main_preview = {
					preview = "main",
					layout = {
						backdrop = false,
						row = 1,
						width = 0.2,
						min_width = 40,
						height = 0.4,
						border = "none",
						box = "vertical",
						{ win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
						{ win = "list", border = "hpad" },
						{ win = "preview", title = "{preview}", border = "rounded" },
					},
				},
			},
			formatters = {
				file = {
					filename_first = false,
					filename_only = true,
				},
			},
			matcher = {
				fuzzy = true,
				smartcase = false,
				ignorecase = false,
				sort_empty = false,
				filename_bonus = true,
				file_pos = true,
				cwd_bonus = false,
				frecency = false,
				history_bonus = false,
			},
		},
		notifier = { enabled = true },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },

		indent = {
			animate = { enabled = false },
			scope = { enabled = false },
		}
	},
	keys = {
		{ "<leader>s", function() Snacks.picker.grep({
			layout = 'ivy_split',
			finder = "grep",
			regex = false,
			format = "file",
			show_empty = true,
			live = true,
			supports_live = true,
			hidden = true,
			ignored = true,
			exclude = exclude,
			smartcase = false,
			ignorecase = false,
		}) end },

		{ "<leader>f", function() Snacks.picker.files({
			finder = "files",
			format = "file",
			show_empty = true,
			hidden = true,
			ignored = true,
			follow = false,
			supports_live = true,
			exclude = exclude,
		}) end },

		{ "<leader>b", function() Snacks.picker.git_branches({
			all = false,
			finder = "git_branches",
			format = "git_branch",
			preview = "git_log",
			confirm = "git_switch",
			win = {input = {keys = {}}},
			on_show = function(picker) for i, item in ipairs(picker:items()) do if item.current then picker.list:view(i) Snacks.picker.actions.list_scroll_center(picker) break end end end,
		}) end },

		{ "<leader>G", function() Snacks.picker.git_status({
			finder = "git_status",
			format = "git_status",
			preview = "git_status",
			win = { input = { keys = { ["-"] = { "git_stage", mode = { "n", "i" } } } } },
		}) end },

		{ "<leader>/", function() Snacks.picker.lines() end },
		{ "<leader>h", function() Snacks.picker.help() end },
		{ "<leader><space>", function() Snacks.picker.resume() end },
		{ "<leader>d", function() Snacks.picker.lsp_definitions() end },
		{ "<leader>r", function() Snacks.picker.lsp_references() end },
		{ "<leader>l", function() Snacks.picker.lazy() end },
	},
}
