local opts = { noremap = true, silent = true } -- noremap: No Recursive remap, silent: no output

local term_opts = { silent = true }

--Shorten function name
local keymap = vim.api.nvim_set_keymap

--Define new leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.localleader = " "

--Info:
--	keymap() takes 4 arguments: Mode, New Map, Target Map, Options

--Modes:
--	- normal_mode "n"
--	- insert_mode "i"
--	- visual_mode "v"
--	- visual_block_mode "<S-v>"
--	- term_mode "t"
--	- command_mode "c"

--Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--Nvim Tree toggle
keymap("n", "<leader>e", ":Explore<cr>", opts)
--Terminal binding
keymap("n", "<leader>t", ":term<cr>", opts)
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)

--Window resizing
keymap("n", "<leader>k", ":resize -2<CR>", opts)
keymap("n", "<leader>j", ":resize +2<CR>", opts)
keymap("n", "<leader>l", ":vertical resize +2<CR>", opts)
keymap("n", "<leader>h", ":vertical resize -2<CR>", opts)

-- Buffer Navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>q", ":Bdelete<CR>", opts)
-- keymap("n", "be", ":BufferLineSortByExtension<CR>", opts)

-- Visual Mode
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

--Telescope
keymap(
	"n",
	"<leader>ff",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>",
	opts
)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)

--Gitsigns
keymap("n", "<leader>g", ":Gitsigns preview_hunk<CR>", opts)

-- vim.diagnostic keymaps
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

-- Formatter 
keymap("n", "<leader>F", ":Format<CR>", opts)
