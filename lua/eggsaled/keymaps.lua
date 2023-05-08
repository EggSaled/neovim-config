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
keymap("n", "<C-h>","<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--Nvim Tree toggle
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
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
keymap("n", "be", ":BufferLineSortByExtension<CR>", opts)

--Block mode: Move text up/down
--	keymap("v", "<Shift>j", ":m +1<CR>==", opts)
--	keymap("v", "<Shift>k", ":m -1<CR>==", opts)

--Telescope
keymap("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)