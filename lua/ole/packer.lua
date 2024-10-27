-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
		'ribru17/bamboo.nvim',
		as = 'bamboo',
		config = function()
			require('bamboo').setup {}
			require('bamboo').load()
		end,
	}

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	use {
		-- LSP
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",

		-- Autocomplete
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
	}
	
	use({
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	})

end)




