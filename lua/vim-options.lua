-- BASIC VIM CONFIGURATION --

vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<ESC>', {})

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.mouse = 'a'
vim.opt.numberwidth = 1


