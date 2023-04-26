local servers = {
	"lua_ls",
	"tsserver",
	"pyright",
	"html",
	"jdtls",
	"jsonls",
	"clangd",
	"sqlls",
	"bashls",
}

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end

local config_ok, mconfig = pcall(require, "mason-lspconfig")
if not config_ok then
	return
end

mason.setup({
	ui = {
		icons = {
		    package_installed = "✓",
		    package_pending = "➜",
		    package_uninstalled = "✗"
		}
	}
    })
mconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lsp_ok, lspconf = pcall(require, "lspconfig")
if not lsp_ok then
	return
end

for _, server in pairs(servers) do
	lspconf[server].setup{}
end
