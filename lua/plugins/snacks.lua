local exclude = {
	"node_modules/",
	"dist/",
	".next/",
	".vite/",
	".git/",
	".yarn/",
	".gitlab/",
	"build/",
	"target/",
	"package-lock.json",
	"pnpm-lock.yaml",
	".pnpm-store/",
	"yarn.lock",
	"translations.json",
	"reports/*.html"
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = false },
		input = { enabled = false },
		picker = {
			win = {
				preview = {
					wo = {
						number = false,
						relativenumber = false,
					},
				},
				input = {
					keys = {
						["<c-f>"] = { "qflist", mode = { "i", "n" } },
					}
				}
			},
			layout = {
				preset = "dropdown_main_preview",
				cycle = false,
			},
			matcher = {
				frecency = true,
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
						{
							win = "input",
							height = 1,
							border = "rounded",
							title = "{title} {live} {flags}",
							title_pos = "center",
						},
						{ win = "list", border = "hpad" },
						{ win = "preview", title = "{preview}", border = "rounded" },
					},
				},
				ivy_split = {
					preview = "main",
					layout = {
						box = "vertical",
						backdrop = false,
						width = 0,
						height = 0.6,
						position = "bottom",
						border = "top",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						},
					},
				},
			},
			main = {
				file = false,
				current = true,
			},
			formatters = {
				file = {
					filename_first = false,
					filename_only = true,
				},
			},
			actions = {
				-- Override to not open qflist, to jump to first, and to update the sidebar qflist display
				qflist = function(picker)
					picker:close()
					local sel = picker:selected()
					local items = #sel > 0 and sel or picker:items()
					local qf = {}
					for _, item in ipairs(items) do
						qf[#qf + 1] = {
							filename = Snacks.picker.util.path(item),
							bufnr = item.buf,
							lnum = item.pos and item.pos[1] or 1,
							col = item.pos and item.pos[2] + 1 or 1,
							end_lnum = item.end_pos and item.end_pos[1] or nil,
							end_col = item.end_pos and item.end_pos[2] + 1 or nil,
							text = item.line or item.comment or item.label or item.name or item.detail or item.text,
							pattern = item.search,
							valid = true,
						}
					end

					vim.fn.setqflist(qf)
					update_quickfix_display()
					vim.cmd("cfirst", { silent = true })
				end,
				-- Override to always open help in vertical split
				help = function(picker, item, action)
					if item then
						picker:close()
						local file = Snacks.picker.util.path(item) or ""
						if package.loaded.lazy then
							local plugin = file:match("/([^/]+)/doc/")
							if plugin and require("lazy.core.config").plugins[plugin] then
								require("lazy").load({ plugins = { plugin } })
							end
						end

						vim.cmd("vert help " .. item.text)
					end
				end,
			},
		},
		terminal = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		indent = {
			animate = { enabled = false },
			scope = { enabled = false },
		},
	},

	keys = {
		{
			"<leader>s",
			function()
				Snacks.picker.grep({
					layout = "ivy_split",
					finder = "grep",
					regex = false,
					format = "file",
					show_empty = true,
					live = true,
					supports_live = true,
					hidden = true,
					ignored = true,
					exclude = exclude,
				})
			end,
		},
		{
			"<leader>t", -- Typescript grep
			function()
				Snacks.picker.grep({
					layout = "ivy_split",
					finder = "grep",
					regex = false,
					format = "file",
					show_empty = true,
					live = true,
					supports_live = true,
					hidden = true,
					ignored = true,
					exclude = exclude,
					ft = "ts",
				})
			end,
		},
		{
			"<leader>f",
			function()
				Snacks.picker.files({
					finder = "files",
					format = "file",
					show_empty = true,
					hidden = true,
					ignored = true,
					follow = false,
					supports_live = true,
					exclude = exclude,
				})
			end,
		},
		{
			"<leader>b",
			function()
				vim.cmd("silent! G fetch")
				Snacks.picker.git_branches({
					layout = "ivy_split",
					all = false,
				})
			end,
		},
		{
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
		},
		{
			"<leader>h",
			function()
				Snacks.picker.help()
			end,
		},
		{
			"<leader><space>",
			function()
				Snacks.picker.resume()
			end,
		},
		{
			"<leader>d",
			function()
				Snacks.picker.lsp_definitions({ focus = "list" })
			end,
		},
		{
			"<leader>r",
			function()
				Snacks.picker.lsp_references({ focus = "list" })
			end,
		},
	},
}
