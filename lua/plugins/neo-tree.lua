return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>t", ":Neotree filesystem reveal right<CR>")
		require("neo-tree").setup({
			filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          visible =  true,
        },
			},
		})
	end,
}
