return {
	{
		"zbirenbaum/copilot.lua",
		enabled = true,

		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-A>"
				}
			}
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end
	}
}

