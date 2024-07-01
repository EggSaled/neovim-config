local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
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
