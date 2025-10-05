return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			auto_install = true,
			ensure_installed = { "nu" },
			highlight = {
				enable = true,
			},
			textobjects = {
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]c"] = "@function.class",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]C"] = "@function.class",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[c"] = "@function.class",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[C"] = "@function.class",
					},
				},
				select = {
					enable = true,

					lookahead = true,

					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						["ac"] = "@class.outer",
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					selection_modes = {
						['@parameter.outer'] = 'v',
						['@function.outer'] = 'V',
						['@class.outer'] = '<c-v>',
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
		dependencies = {
			{ "nushell/tree-sitter-nu" },
		},
		build = ":TSUpdate"
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" }
}
