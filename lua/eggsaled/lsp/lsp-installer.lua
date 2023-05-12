local servers = {
	"bashls",
	"clangd",
	"html",
	"jdtls",
	"jsonls",
	"lua_ls",
	"pyright",
	"sqlls",
	"tsserver",
}

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end

local config_ok, mconfig = pcall(require, "mason-lspconfig")
if not config_ok then
	return
end

local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
mconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local config = {
	virtual_text = false,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

lsp = lsp.preset({})
lsp.on_attach(function(client, bufnr)
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	end
	lsp.default_keymaps({ bufnr = bufnr })
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
