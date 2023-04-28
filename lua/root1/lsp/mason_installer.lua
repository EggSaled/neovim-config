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

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_attach = function(client, bufnr)
	--Keybindings here	
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(
	    bufnr,
	    "n",
	    "gl",
	    '<cmd>lua vim.diagnostic.open_float()<CR>',
	    opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

	if client.server_capabilities.documentHighlight then
		vim.api.nvim_exec(
		[[
			augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]],
		false
		)
	end

end

-- local lspconfig = require("lspconfig")
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local get_servers = mconfig.get_installed_servers

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

for _, server_name in ipairs(get_servers()) do
	local opts = {
		on_attach = lsp_attach,
		capabilities = lsp_capabilities,
	}
	if server_name == "tsserver" then
		opts.capabilities.documentHighlight = false
	end

	local settings_ok, settings = pcall(require, "root1.lsp.settings" .. server_name)
	if settings_ok then
		vim.tbl_deep_extend("force", settings, opts)
	end

	lspconfig[server_name].setup(opts)
end
