return {
	{
		"numToStr/FTerm.nvim",
		config = function ()
			require("FTerm").setup({
				border = 'single',
				blend = 0;
				dimensions  = {
					height = 0.9,
					width = 0.9,
				},
			})
		end
	}
}
