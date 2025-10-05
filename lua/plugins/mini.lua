return {
	'echasnovski/mini.nvim',
	opts = {
		mini = {
			view = {
				style = "sign",
				signs = { add = "|", change = "|", delete = "|" }
			}
		},
	},
	config = function(_, opts)
		require('mini.comment').setup()
		require('mini.cursorword').setup()
		require('mini.diff').setup(opts.mini)
		require('mini.pairs').setup()
		require('mini.surround').setup()
	end
}
