local opts = { noremap = true, silent = true } -- noremap: No Recursive remap, silent: no output

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

--Lexplore binding
keymap("n", "<leader>e", ":Lex 25<cr>", opts)
--Terminal binding
keymap("n", "<leader>t", ":term<cr>", opts)
keymap("t", "<ESC>", "<C-\\><C-n>", opts)

--Window resizing
keymap("n", "<leader>k", ":resize -2<CR>", opts)
keymap("n", "<leader>j", ":resize +2<CR>", opts)
keymap("n", "<leader>l", ":vertical resize +2<CR>", opts)
keymap("n", "<leader>h", ":vertical resize -2<CR>", opts)

--Window Splitting

--Block mode: Move text up/down
--NOTE: Not working on MacOS.
--	keymap("v", "<A-j>", ":m +1<CR>==", opts)
--	keymap("v", "<A-k>", ":m -1<CR>==", opts)
