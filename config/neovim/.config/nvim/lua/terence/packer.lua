-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = {
			'nvim-lua/plenary.nvim',
			-- optional but recommended
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
		}
	}
	use "nvim-lua/plenary.nvim"
	use { "ellisonleao/gruvbox.nvim" }
	use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	
	-- File Explorer
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- icone per i file
		},
	}
	
	-- Markdown Preview
	use {
		'iamcco/markdown-preview.nvim',
		run = 'cd app && npm install',
		ft = { 'markdown' },  -- Carica solo per file .md
	}
	
	-- LSP
	use {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
	}
	
	-- Autocompletion
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		}
	}
	
	-- Signature help automatico
	use {
		'ray-x/lsp_signature.nvim'
	}
	
	-- UI moderna per command line, messages e popups
	use {
		'folke/noice.nvim',
		requires = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		}
	}
	
	-- Help menu per keybindings
	use {
		'folke/which-key.nvim'
	}
	
	-- Statusline per vedere mode e info
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons' }
	}
	
	-- GitHub Copilot
	use {
		'zbirenbaum/copilot.lua',
		cmd = "Copilot",
		event = "InsertEnter",
	}
	use {
		'zbirenbaum/copilot-cmp',
		after = { "copilot.lua" },
	}
end)
