return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		"natecraddock/telescope-zf-native.nvim",
		"tpope/vim-fugitive",
		"tpope/vim-rhubarb",
		"aaronhallaert/advanced-git-search.nvim",
		'mrloop/telescope-git-branch.nvim',
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
				mappings = {
					i = {
						-- Send but don't open quickfix
						["<C-q>"] = require('telescope.actions').send_to_qflist,
					},
					n = {
						["<C-q>"] = require('telescope.actions').send_to_qflist,
					}
				}
			},
			pickers = {
				git_branches = {
					mappings = {
						i = {
							['<CR>'] = require('telescope.actions').git_switch_branch,
						},
						n = {
							['<CR>'] = require('telescope.actions').git_switch_branch,
						},
					}
				},
			}
		})

		local function browse(x)
			return '<cmd>Telescope ' .. x .. ' initial_mode=normal <cr>'
		end

		local function search(x)
			return '<cmd>Telescope ' .. x .. '<cr>'
		end

		vim.keymap.set({ 'n', 'v' }, '<leader>d', search("lsp_definitions"))
		vim.keymap.set({ 'n', 'v' }, '<leader>f', search("find_files"))
		vim.keymap.set({ 'n', 'v' }, '<leader>r',  browse('lsp_references'))
		vim.keymap.set({ 'n', 'v' }, '<leader>o',  browse('buffers'))
		vim.keymap.set({ 'n', 'v' }, '<leader>h', search('help_tags'))
		vim.keymap.set({ 'n', 'v' }, '<leader><leader>', browse('resume') )
		vim.keymap.set({ 'n', 'v' }, '<leader>b', search('git_branches'))
		vim.keymap.set({ 'n', 'v' }, '<leader>e', browse('diagnostics severity=error'))
		vim.keymap.set({ 'n', 'v' }, '<leader>/', browse('search_history'))
		vim.keymap.set({ 'n', 'v' }, '<leader>l', browse('diagnostics severity=error'))
		vim.keymap.set({ 'n', 'v' }, '<leader>ag', ':Telescope advanced_git_search')
		vim.keymap.set({ 'n', 'v' }, '<leader>G', browse('git_branch'))
		vim.keymap.set({ 'n', 'v' }, "<leader>'", browse('recall'))
		-- Quickfix
		vim.keymap.set({ 'n', 'v' }, '<C-d>', '<CMD>cnext<CR>')
		vim.keymap.set({ 'n', 'v' }, '<C-u>', '<CMD>cprevious<CR>')

		-- Custom grep
		vim.keymap.set("n", "<leader>s", function(opts)
			opts = opts or {}
			opts.cwd = opts.cwd or vim.uv.cwd()

			require("telescope.pickers")
				.new(opts, {
					prompt_title = "Search",
					debounce = 100,
					previewer = require("telescope.config").values.grep_previewer(opts),
					sorter = require("telescope.sorters").empty(),
					finder = require('telescope.finders').new_async_job({
						command_generator = function(prompt)
							if not prompt or prompt == "" then
								return nil
							end

							local arguments, text = prompt:match("(%S*)%s?(.*)")
							local args = { "rg" }

							if text ~= '' then
								table.insert(args, "-e")
								table.insert(args, text)
							else
								return nil
							end

							if arguments ~= '' then
								local location, second_part = arguments:match("([hra]?)(.*)")
								local filetype = second_part:match("%..+")
								local glob

								if filetype ~= nil then
									local parts = {}
									for part in filetype:gmatch("([^%.]+)") do
										table.insert(parts, part)
									end
									filetype = '.' .. '{' .. table.concat(parts, ',') .. '}'
								end

								if location == 'r' and filetype == nil then
									glob = 'services/report-maker/**'
								elseif location == 'h' and filetype == nil then
									glob = 'apps/hent-core/**'
								elseif location == 'a' and filetype == nil then
									glob = 'services/restful-api/**'
								elseif location == 'r' and filetype ~= nil then
									glob = 'services/report-maker/**/*'..filetype
								elseif location == 'h' and filetype ~= nil then
									glob = 'apps/hent-core/**/*'..filetype
								elseif location == 'a' and filetype ~= nil then
									glob = 'services/restful-api/**/*'..filetype
								elseif location == '' and filetype ~= nil then
									glob = '*'..filetype
								else
									goto no_args
								end

								table.insert(args, "-g")
								table.insert(args, glob)
							end
							::no_args::

							return vim.tbl_flatten {
								args,
								{
									"--color=never",
									"--no-heading",
									"--with-filename",
									"--line-number",
									"--column",
									"--smart-case",
									'--ignore-file',
									'.gitignore'
								},
							}
						end,
						entry_maker = function (entry)
							local vimgrep_entry = require("telescope.make_entry").gen_from_vimgrep({
								disable_coordinates = true,
							})(entry)

							local old_display = vimgrep_entry.display
							vimgrep_entry.display = function (e)
								local raw, style = old_display(e)
								local file, line = raw:match("^([^:]+):[^%S]*(.+)$")

								local len_filename = 30
								local const_len_filename
								if #file > len_filename then
									const_len_filename = file:sub(1, len_filename)
								elseif #file < len_filename then
									const_len_filename = file .. string.rep(" ", len_filename - #file)
								else
									const_len_filename = file
								end

								local len_line = 150
								line = line:sub(1, len_line)

								return const_len_filename .. '║' .. line, style
							end

							return vimgrep_entry;
						end,
					}),
				})
				:find()
		end)

		require("telescope").load_extension("zf-native")
		require("telescope").load_extension("advanced_git_search")
		require("telescope").load_extension("git_branch")
	end
}
