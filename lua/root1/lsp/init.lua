local mason_ok, _ = pcall(require, "mason")
if not mason_ok then
	return
end
local masonconf_ok, _ = pcall(require, "mason-lspconfig")
if not masonconf_ok then
	return
end

require("root1.lsp.mason_installer")
