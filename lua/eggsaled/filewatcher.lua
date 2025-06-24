local autocmd = vim.api.nvim_create_autocmd

-- LSP autocmd

local lsp_opts = {
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

for _, v in pairs(lsp_opts) do
	autocmd("FileType", {
		pattern = v[2],
		callback = function(args)
			-- Check if the lsp server is not already enabled.
			if not vim.lsp.is_enabled(v[1]) then
				vim.lsp.enable(v[1], true)
			end
		end
	})
end

-- Treesitter autocmd

local treesitter_opts = {
	"c",
	"css",
	"editorconfig",
	"html",
	"java",
	"javascript",
	"json",
	"lua",
	"markdown",
	"python",
	"typescript",
}

for _, language in ipairs(treesitter_opts) do
	autocmd("FileType", {
		pattern = vim.treesitter.language.get_filetypes(language),
		callback = function(args)
			if vim.treesitter.language.add(language) then
				vim.treesitter.start(args.bufnr, language)
			end
		end
	})
end
