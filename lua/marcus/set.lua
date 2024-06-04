vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }
vim.opt.relativenumber = true
vim.o.background = "dark"

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.clipboard = "unnamed"
