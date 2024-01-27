return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<LEADER>j",
					},
				},
				panel = {
          enabled = false,
          auto_refresh = true,
          keymap =  {
            accept = "<CR>",
            refresh = "gr",
          },
        },
			})
      vim.keymap.set("n", "<LEADER>s", ":Copilot panel<CR>", {})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
