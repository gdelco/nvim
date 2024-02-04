
return {
  {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local tlsc = require("telescope.builtin")
    vim.keymap.set('n', '<LEADER>ff', tlsc.find_files, {})
    vim.keymap.set('n', '<LEADER>fb', tlsc.buffers, {})
    vim.keymap.set('n', '<LEADER>fg', tlsc.live_grep, {})
  end
  },
  -- {
  -- "nvim-telescope/telescope-ui-select.nvim",
  -- config = function()
  --   require("telescope").setup({
  --     extensions = {
  --       ["ui-select"] = {
  --         require("telescope.themes").get_dropdown {
  --         }
  --       }
  --     }
  --   })
  --   -- require("telescope").load_extension("ui-select")
  -- end
  -- },
}
