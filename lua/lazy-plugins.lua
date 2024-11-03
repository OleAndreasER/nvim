-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local standard_float_width = 70;
local standard_float_height = 40;

require("lazy").setup({
	-- Color Scheme
	{
	  'ribru17/bamboo.nvim',
	  lazy = false,
	  priority = 1000,
	  config = function()
		require('bamboo').setup()
		require('bamboo').load()
	  end,
	},
	-- File Manager
	{
		'stevearc/oil.nvim',
		opts = {},
		config = function()
			local oil = require("oil")
			oil.setup({
				columns = {},
				watch_for_changes = true,
				keymaps = {
					["<C-s>"] = { "actions.select", opts = { vertical = true } },
					["-"] = "actions.parent",
					["g."] = "actions.toggle_hidden",
					["<esc>"] = "actions.close"
				},
				float = {
					border = "rounded",
					max_width = standard_float_width,
					max_height = standard_float_height,
					win_options = {
						winblend = 0,
					},
				},		
				view_options = {
					show_hidden = false,
					-- This function defines what will never be shown, even when `show_hidden` is set
					is_always_hidden = function(name, bufnr)
						return name == '.git' or name == '..' 
					end,
					sort = {
						{ "type", "asc" },
						{ "name", "asc" },
					},
				},
			})

			vim.keymap.set("n", "-", function()
				oil.open_float()
			end)
		end
	},
	-- Searching 
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim', 'm-demare/attempt.nvim' },
		config = function()
			local actions = require('telescope.actions')
			require('telescope').setup({
				defaults = { color_devicons = false },

			})
			local function browse(x)
				return '<cmd>Telescope ' .. x .. ' sort_mru=true sort_lastused=true initial_mode=normal<cr>'
			end

			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>tf', builtin.git_files)
			vim.keymap.set('n', '<leader>tb', builtin.git_branches)
			vim.keymap.set('n', '<leader>tg', builtin.live_grep)
			vim.keymap.set('n', '<leader>tc', builtin.grep_string)
			vim.keymap.set('n', '<leader>tt', builtin.builtin)
			vim.keymap.set('n', '<leader>to', browse('buffers'))
			vim.keymap.set('n', '<leader>td', builtin.lsp_definitions)
			vim.keymap.set('n', '<leader>tD', builtin.lsp_type_definitions)
			vim.keymap.set('n', '<leader>tr',  browse('lsp_references'))
			vim.keymap.set('n', '<leader>ta', browse('attempt'))
			vim.keymap.set('n', '<leader>te', browse('diagnostics'))

			require('telescope').load_extension('attempt')
		end
	},
	-- Git
	{
		'lewis6991/gitsigns.nvim',
		config = function ()
			require('gitsigns').setup({
			})
		end
	},
	{
		'tpope/vim-fugitive',
		config = function()

			-- Fugitive in float (https://www.reddit.com/r/neovim/comments/1ag5mk3/fugitive_change_window_to_popup/)
			vim.api.nvim_create_user_command('FugitiveFloat', function()
				ui = vim.api.nvim_list_uis()[1]

				local width = 100
				local height = standard_float_height

				local win_config = {
					relative = "editor",
					width = width,
					height = height,
					col = (ui.width - width) / 2,
					row = (ui.height - height) / 2,
					style = 'minimal',
					focusable = true,
					border = 'rounded'
				}

				if not fugitive_float_bufnr then
					fugitive_float_bufnr = vim.api.nvim_create_buf(false, true)
					vim.api.nvim_open_win(fugitive_float_bufnr, true, win_config)
					vim.cmd(':Gedit :')
					vim.cmd('normal 5j')
				elseif vim.api.nvim_win_get_buf(0) == fugitive_float_bufnr then
					vim.api.nvim_command('hide')
				else
					print('1234')
					vim.api.nvim_open_win(fugitive_float_bufnr, true, win_config)
					vim.cmd(':Gedit :')
					vim.cmd('normal 5j')
				end
			end, {})

			vim.keymap.set("n", "<leader>g", '<cmd>FugitiveFloat<cr>')
		end,
	},
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			message_template = "<author> - <summary> - <date>",
			date_format = "%d/%m/%Y",
		},

	},
	-- Lua line
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup({
				options = {
					icons_enabled = false,
					theme = 'auto',
					component_separators = { left = '', right = ''},
					always_divide_middle = true,
					globalstatus = true,
				},
				winbar = {
					lualine_c = {
						'%=',
						{
							'filename',
							symbols = {
								unnamed = '',
								modified = '●',
								readonly = '',
							},
						},
						'%='
					},
				},
				inactive_winbar = {
					lualine_c = {
						'%=',
						{
							'filename',
							symbols = {
								unnamed = '',
								modified = '●',
								readonly = '',
							},
						},
						'%='
					},
				},
				sections = {
					lualine_a = {'mode'},
					lualine_b = {'branch' },
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {}
				},
				extensions = { }
			})
		end,
	},
	-- Comment lines
	{
		'numToStr/Comment.nvim',
		config = function ()
			require('Comment')
		end
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
				},
				mapping = cmp.mapping.preset.insert({
					['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
					['<Enter>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim", "hrsh7th/nvim-cmp" },
		config = function()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					require("lspconfig")[server_name].setup({
						capabilities = capabilities
					})
				end,

				['eslint'] = function()
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					require("lspconfig").eslint.setup({
						capabilities = capabilities
					})
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	-- Tree sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					"javascript",
					"typescript",
					"bash",
					"bicep",
					"css",
					"dockerfile",
					"gitignore",
					"html",
					"json",
					"scss",
					"xml",
					"yaml"
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<Leader>ss",
						scope_incremental = "<Leader>sc",
						node_incremental = "<Leader>si",
						node_decremental = "<Leader>sd",
					}
				}
			}
		end,
	},
	-- Managing temp files/attempts
	{
		'm-demare/attempt.nvim',
		config = function()
			local attempt = require('attempt')
			attempt.setup({
				ext_options = { '', 'js', 'ts' },
				format_opts = { [''] = 'Note' },
				run = {
					js = { 'w !node' },
					ts = { 'w !yarn tsx' },
				}
			})

			vim.keymap.set('n', '<leader>an', attempt.new_select)
			vim.keymap.set('n', '<leader>ai', attempt.new_input_ext)
			vim.keymap.set('n', '<leader>ar', attempt.run)
			vim.keymap.set('n', '<leader>ad', attempt.delete_buf)
		end,
	},
	-- Terminal
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = '<c-k>',
				hide_numbers = true,
				autochdir = false,
				start_in_insert = true,
				persist_size = true,
				persist_mode = true,
				direction = 'float',
				shell = 'powershell',
				auto_scroll = true,
				float_opts = {
					border = 'curved',
					width = standard_float_width,
					height = standard_float_height,
					winblend = 0,
					title_pos = 'left',
				},
			})
		end,
	},
})

