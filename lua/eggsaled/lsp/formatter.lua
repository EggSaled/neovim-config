local status_ok, formatter = pcall(require, "formatter")

if not status_ok then
	return
end

local util = require("formatter.util")

formatter.setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		javascript = {
			require("formatter.filetypes.javascript").eslint_d,
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").eslint_d
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
			function()
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true
				}
			end,
		},
		python = {
			require("formatter.filetypes.python").black
		},
		typescript = {
			require("formatter.filetypes.typescript").eslint_d
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").eslint_d
		}
	},
})
