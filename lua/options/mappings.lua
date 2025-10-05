

-- Mappings
local map = vim.keymap.set

-- Copy pasting
map('n', '<Leader>p', '"+p')
map('n', '<Leader>P', '"+P')
map('n', '<Leader>Y', '"+Y')
map('n', '<Leader>y', '"+y')
map('v', '<Leader>p', '"+p')
map('v', '<Leader>P', '"+P')
map('v', '<Leader>Y', '"+Y')
map('v', '<Leader>y', '"+y')

-- Moving through splits
map('n', '<C-l>', '<C-w>l')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-h>', '<C-w>h')

map('n', '<C-y>', '10<C-y>')
map('n', '<C-e>', '10<C-e>')


-- Telescope
local telescope = require('telescope.builtin')
map('n', '<leader>f', telescope.find_files, {})
map('n', '<leader>F', telescope.git_files, {})
map('n', '<leader>g', telescope.live_grep, {})
map('n', '<leader>b', telescope.buffers, {})

-- LSP
map('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
map('n', 'K', vim.lsp.buf.hover)
map('n', 'gd', vim.lsp.buf.definition)
map('n', 'gr', vim.lsp.buf.references)
map('n', ',rn', vim.lsp.buf.rename)
map('n', ',ca', vim.lsp.buf.code_action)
map('n', '<F3>', vim.lsp.buf.format)
map('n', ',e', vim.diagnostic.open_float)

-- Go to alternate file
map('n', '<Leader>e', '<cmd>:e#<cr>')
map('t', '<Leader><ESC>', '<C-\\><C-N>')


-- Float term
map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- Quickfix
map('n', ']q', '<cmd>cnext<cr>')
map('n', '[q', '<cmd>cnext<cr>')
map('n', ']Q', '<cmd>cfirst<cr>')
map('n', '[Q', '<cmd>clast<cr>')
map('n', '<leader>qq', '<cmd>cclose<cr>')
