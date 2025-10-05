
vim.opt.ph = 10
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.opt.mouse = "a"

vim.opt.colorcolumn = "89"

vim.opt.conceallevel = 2


vim.api.nvim_create_augroup('custom_filetypes', { clear = true })

-- Add an autocmd to set the filetype of .ejs files to html
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'custom_filetypes',
  pattern = '*.ejs',
  command = 'set filetype=html',
})

vim.opt.scrolloff = 5
