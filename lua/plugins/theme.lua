local function read_mode()
  local f = io.open(vim.env.HOME .. "/.cache/theme-mode", "r")
  if not f then return "dark" end
  local m = (f:read("*l") or "dark"):gsub("%s+", "")
  f:close()
  return (m == "light") and "light" or "dark"
end

local function apply(mode)
  vim.o.background = mode
  vim.cmd.colorscheme("everforest")
  pcall(function() require("lualine").refresh() end)
end

return {
  "sainnhe/everforest",
  priority = 1000,
  lazy = false,
  config = function()
    vim.g.everforest_background = "medium"
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_better_performance = 1
    apply(read_mode())

    vim.api.nvim_create_user_command("ThemeRefresh", function()
      apply(read_mode())
    end, {})
  end,
}
