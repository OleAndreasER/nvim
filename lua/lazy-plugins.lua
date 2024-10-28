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

require("lazy").setup({
	-- Color Scheme
	{
	  'ribru17/bamboo.nvim',
	  lazy = false,
	  priority = 1000,
	  config = function()
		require('bamboo').setup{}
		require('bamboo').load()
	  end,
	},
	-- File Manager
	{
		'stevearc/oil.nvim',
		opts = {},
		config = function()
			require("oil").setup({
				columns = {},
				watch_for_changes = true,
				keymaps = {
					["<C-s>"] = { "actions.select", opts = { vertical = true } },
					["<C-p>"] = "actions.preview",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["g."] = "actions.toggle_hidden",
				},
				view_options = {
					show_hidden = false,
					-- This function defines what is considered a "hidden" file
					is_hidden_file = function(name, bufnr)
						return vim.startswith(name, ".")
					end,
					-- This function defines what will never be shown, even when `show_hidden` is set
					is_always_hidden = function(name, bufnr)
						return name == '.git'
					end,
					sort = {
						{ "type", "asc" },
						{ "name", "asc" },
					},
				},
			})
			vim.keymap.set("n", "-", "<CMD>Oil<CR>")
		end,
	},
	-- Searching 
    {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function ()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.git_files)
			vim.keymap.set('n', '<leader>fg', builtin.live_grep)
			vim.keymap.set('n', '<leader>fs', builtin.grep_string)
		end
    },
	-- Git Blame
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			message_template = "<author> - <summary> - <date>",
			date_format = "%d-%m-%Y",
		},

	},
	-- Lua line
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup({
				options = {
					icons_enabled = false,
					theme = 'auto',
					component_separators = { left = '', right = ''},
					section_separators = { left = '', right = ''},
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {
					lualine_a = {'mode'},
					lualine_b = {'branch', 'filename' },
					lualine_c = {},
					lualine_x = {'diff', 'diagnostics'},
					lualine_y = {},
					lualine_z = {}
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {'filename'},
					lualine_x = {'location'},
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {}
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
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<Tab>'] = cmp.mapping.confirm({
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
			})
		end,
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
})

