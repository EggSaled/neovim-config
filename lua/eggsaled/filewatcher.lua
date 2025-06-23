--[[
	filewatcher.lua

	Since plugin `nvim-lspconfig` already has default configs for the lsp's currently installed
	(by Mason), `opts` will be used to create autocmds for files I expect to frequently edit.
]]

-- opts contains the name of the lsp config, and the filetypes (derived from the config) to attach the autocmd to

local opts = {
	{ "bashls", { "bash", "sh" } },
	{ "clangd", { "c", "cpp" } },
	{ "cssls", { "css", "scss", "less" } },
	{ "html", { "html" } },
	{ "intelephense", { "php" } },
	{ "jdtls", { "java" } },
	{ "pyright", { "python" } },
	{ "rust_analyzer", { "rust" } },
	{ "sqlls", { "sql", "mysql" } },
	{ "ts_ls", { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" } },
}

local autocmd = vim.api.nvim_create_autocmd

for _, v in pairs(opts) do
	autocmd("FileType", {
		pattern = v[2],
		callback = function()
			-- Check if the lsp server is not already enabled.
			if not vim.lsp.is_enabled(v[1]) then
				vim.lsp.enable(v[1], true);
			end
		end
	})
end
