return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	opts = {
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
	}
}
-- NOTE: copied from options, not sure if this still works.

--[[ WORKAROUND FOR TREESITTER FOLDS
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
	  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
	  callback = function()
		  vim.opt.foldmethod = 'expr'
		  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
	  end
--]]})
