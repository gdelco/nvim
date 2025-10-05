return {
  -- "srcery-colors/srcery-vim",
  -- name = "srcery",
  -- priority = 1000,
  -- config = function()
  --   vim.cmd.colorscheme "srcery"
  -- end,
	-- "sainnhe/gruvbox-material",
	-- name = "gruvbox-material",
	-- priority = 1000,
	-- config = function()
	--   vim.cmd.colorscheme "gruvbox-material"
	-- end
  -- "oxfist/night-owl.nvim",
  -- name="night-owl",
  -- lazy= false,
  -- priority = 1000,
  -- config = function()
  --   require("night-owl").setup()
  --   vim.cmd.colorscheme("night-owl")
  -- end,
	"rebelot/kanagawa.nvim",
  name="kanagawa",
  lazy= false,
  priority = 1000,
  config = function()
    require("kanagawa").setup()
    vim.cmd.colorscheme("kanagawa-wave")
    -- vim.cmd.colorscheme("kanagawa-lotus")
    -- vim.cmd.colorscheme("kanagawa-dragon")
  end,
	

}
