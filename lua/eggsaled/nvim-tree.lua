local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, config = pcall(require, "nvim-tree.config")
if not status_ok then
	return
end

local icon_status_ok, icons = pcall(require, "nvim-web-devicons")
if not icon_status_ok then
	vim.notify("Icons not found! Nvim-Tree will not display the icons properly.")
end

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
})
