return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'm-demare/attempt.nvim',
			'nvim-tree/nvim-web-devicons',
			"natecraddock/telescope-zf-native.nvim",
			"tpope/vim-fugitive",
			"tpope/vim-rhubarb",
			"aaronhallaert/advanced-git-search.nvim",
		},
		config = function()
			require('telescope').setup({
				defaults = {
					file_ignore_patterns = { "node_modules", '.git/' },
					prompt_prefix = "> ",
					selection_caret = "> ",
					entry_prefix = "  ",
					vimgrep_arguments = {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
						'--ignore-file',
						'.gitignore'
					},
					sorting_strategy = 'ascending',
					layout_config = {
						width = 0.6,
						height = 0.8,
						prompt_position = 'top',
					},
					results_title = false,
					borderchars = {
						results = { " ", " ", " ", " ", " ", " ", " ", " " },
						prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
						preview = { " ", " ", " ", " ", " ", " ", " ", " " },
					},
					path_display = {
						"tail"
					},
				},
			})

			local function browse(x)
				return '<cmd>Telescope ' .. x .. ' initial_mode=normal <cr>'
			end

			local function search(x)
				return '<cmd>Telescope ' .. x .. '<cr>'
			end

			vim.keymap.set('n', '<leader>d', search("lsp_definitions"))
			vim.keymap.set('n', '<leader>n', search("lsp_dynamic_workspace_symbols"))
			vim.keymap.set('n', '<leader>f', search("find_files"))
			vim.keymap.set('n', '<leader>r',  browse('lsp_references'))
			vim.keymap.set('n', '<leader>o',  browse('buffers'))
			vim.keymap.set('n', '<leader>h', search('help_tags'))
			-- vim.keymap.set('n', '<leader>s', search('live_grep') )
			vim.keymap.set('n', '<leader><leader>', browse('resume') )
			vim.keymap.set('n', '<leader>b', search('git_branches'))
			vim.keymap.set('n', '<leader>e', browse('diagnostics severity=error'))
			vim.keymap.set('n', '<leader>l', browse('diagnostics severity=error'))
			vim.keymap.set('n', '<leader>ag', ':Telescope advanced_git_search')

			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local make_entry = require("telescope.make_entry")
			local conf = require("telescope.config").values
			vim.keymap.set("n", "<leader>s", function(opts)
				opts = opts or {}
				opts.cwd = opts.cwd or vim.uv.cwd()

				local finder = finders.new_async_job {
					command_generator = function(prompt)
						if not prompt or prompt == "" then
							return nil
						end

						local pieces = vim.split(prompt, "  ")
						local args = { "rg" }
						if pieces[1] then
							table.insert(args, "-e")
							table.insert(args, pieces[1])
						end

						if pieces[2] then
							table.insert(args, "-g")
							table.insert(args, pieces[2])
						end

						---@diagnostic disable-next-line: deprecated
						return vim.tbl_flatten {
							args,
							{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
						}
					end,
					entry_maker = make_entry.gen_from_vimgrep(opts),
					cwd = opts.cwd,
				}

				pickers.new(opts, {
					debounce = 100,
					prompt_title = "Multi Grep",
					finder = finder,
					previewer = conf.grep_previewer(opts),
					sorter = require("telescope.sorters").empty(),
				}):find()
			end)


			require("telescope").load_extension("zf-native")
			require("telescope").load_extension("advanced_git_search")
		end
	},
}
