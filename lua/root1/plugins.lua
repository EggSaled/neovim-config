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
	use "folke/tokyonight.nvim"
	use {
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
	use {
	    "williamboman/mason.nvim",
	    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
	}
	use "williamboman/mason-lspconfig.nvim"
	use "neovim/nvim-lspconfig"

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)
