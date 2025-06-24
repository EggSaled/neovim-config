return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function(args)
		local config = require('nvim-treesitter.config')

		config.setup({
			ensure_installed = { "javascript", "c", "cpp", "vim", "vimdoc", "java", "json", "json5", "lua", "python", "sql", "swift", "typescript" },
			sync_install = false,
			auto_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
				disable = { "yaml" },
			},
		})
	end,
}
