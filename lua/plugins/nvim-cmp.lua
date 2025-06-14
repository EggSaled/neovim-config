-- TODO: Complete setup of nvim-cmp, set up plugin files for
-- 	buffer, path, and cmdline
return {
	"hrsh7th/nvim-cmp",
	config = function()
		local kind_icons = {
		  Text = "",
		  Method = "m",
		  Function = "",
		  Constructor = "",
		  Field = "",
		  Variable = "",
		  Class = "",
		  Interface = "",
		  Module = "",
		  Property = "",
		  Unit = "",
		  Value = "",
		  Enum = "",
		  Keyword = "",
		  Snippet = "",
		  Color = "",
		  File = "",
		  Reference = "",
		  Folder = "",
		  EnumMember = "",
		  Constant = "",
		  Struct = "",
		  Event = "",
		  Operator = "",
		  TypeParameter = "",
		}
		
		-- nvim-cmp setup	
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					-- Using luasnip
					require('luasnip').lsp_expand(args.body)
				end,
			},	
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind], vim_item.kind)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "luasnip" },
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			experimental = {
				ghost_text = false,
				native_menu = false,
			},
		})
	end,
}
