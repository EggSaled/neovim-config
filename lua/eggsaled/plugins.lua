local fn = vim.fn

--Automatically install package manager for NeoVim
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer, please close and reopen Neovim."
	vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("Packer not found.")
	return
end

--Floating window setup
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

--Begin plugin install
return packer.startup(function(use)
	use "wbthomason/packer.nvim" -- Have Packer manage itself
	use "nvim-lua/popup.nvim"
	use "nvim-lua/plenary.nvim"
	use "folke/tokyonight.nvim" -- Colorscheme
	-- Better Syntax Highlighting
	use {
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
	-- LSP
	use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
	    -- LSP Support
	    {'neovim/nvim-lspconfig'},             -- Required
	    {                                      -- Optional
	      'williamboman/mason.nvim',
	      run = function()
		pcall(vim.cmd, 'MasonUpdate')
	      end,
	    },
	    {'williamboman/mason-lspconfig.nvim'}, -- Optional

	    -- Autocompletion
	    {'hrsh7th/nvim-cmp'},     -- Required
	    {'hrsh7th/cmp-nvim-lsp'}, -- Required
	    {'L3MON4D3/LuaSnip'},     -- Required
	  }
	}
	use "jose-elias-alvarez/null-ls.nvim"
	-- Autocompletion
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "saadparwaiz1/cmp_luasnip"
	use "rafamadriz/friendly-snippets"
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
	-- Git Signs
	use "lewis6991/gitsigns.nvim"
	-- Nvim-Tree (Better alternative to Netrw)
	use {
		'nvim-tree/nvim-tree.lua',
	  	requires = {
	    	'nvim-tree/nvim-web-devicons', -- optional
	  	}
	}
	-- Bufferline
	use "akinsho/bufferline.nvim"
	-- BBye (For closing buffers made by bufferline)
	use "moll/vim-bbye"

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)
