
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }

keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader =  ' '
vim.g.maplocalleaer = ' '

keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)

keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- buffer
keymap("n", "<leader>bs", ":w<cr>", opts)
keymap("n", "<leader>bd", ":bdelete<cr>", opts)
keymap("n", "<leader>br", ":edit!<cr>", opts)

-- pane
keymap("n", "<leader>wd", ":close<cr>", opts)

-- telescope
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>/", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>,", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)


-- rest
keymap("n", "<leader>rr", "<Plug>RestNvim", opts)
keymap("n", "<leader>rc", "<Plug>RestNvim", opts)
keymap("n", "<leader>rl", "<Plug>RestNvim", opts)
