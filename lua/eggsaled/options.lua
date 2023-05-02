vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 300
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cmdheight = 2
vim.opt.wrap = false
vim.opt.autoread = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- vim.opt.copyindent = true
vim.opt.termguicolors = true

--Plugin dependent options

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("Packer not found, remaining options dependent on plugins will not be executed.")
	return
end

--WORKAROUND FOR TREESITTER FOLDS
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
	group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
	callback = function()
		vim.opt.foldmethod = 'expr'
		vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
	end
})
