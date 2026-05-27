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
		vim.keymap.set("n", "<leader>T", ":Neotree git_status reveal right<CR>")
		require("neo-tree").setup({
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					visible = true,
				},
			},
		})
	end,
}
