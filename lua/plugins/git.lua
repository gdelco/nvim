return {
	{ "tpope/vim-fugitive" },
	{ 'akinsho/git-conflict.nvim', version = "*", config = true },
	{
		"polarmutex/git-worktree.nvim",
		version = "^2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("git_worktree")
		end,
		keys = {
			{
				"<leader>wl",
				function() require("telescope").extensions.git_worktree.git_worktree() end,
				desc = "Worktrees: list / switch",
			},
			{
				"<leader>wn",
				function()
					vim.ui.input({ prompt = "New branch name: " }, function(branch)
						if not branch or branch == "" then return end
						local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
						local default_path = vim.fn.fnamemodify(repo_root, ":h") .. "/"
							.. vim.fn.fnamemodify(repo_root, ":t") .. "-" .. branch:gsub("/", "-")
						vim.ui.input({ prompt = "Worktree path: ", default = default_path }, function(path)
							if not path or path == "" then return end
							vim.ui.input({ prompt = "Upstream (blank = HEAD): " }, function(upstream)
								require("git-worktree").create_worktree(path, branch, upstream ~= "" and upstream or nil)
							end)
						end)
					end)
				end,
				desc = "Worktrees: create new",
			},
		},
	},
	{
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			signs = {
				add          = { text = '┃' },
				change       = { text = '┃' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			current_line_blame = false,
			current_line_blame_opts = { delay = 400, virt_text_pos = 'eol' },
			preview_config = { border = 'rounded' },
			on_attach = function(bufnr)
				local gs = require('gitsigns')
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation between hunks
				map('n', ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, 'Next hunk')
				map('n', '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, 'Prev hunk')

				-- Actions
				map('n', '<leader>hp', gs.preview_hunk,        'Preview hunk')
				map('n', '<leader>hs', gs.stage_hunk,          'Stage hunk')
				map('n', '<leader>hr', gs.reset_hunk,          'Reset hunk')
				map('n', '<leader>hu', gs.undo_stage_hunk,     'Undo stage hunk')
				map('n', '<leader>hS', gs.stage_buffer,        'Stage buffer')
				map('n', '<leader>hR', gs.reset_buffer,        'Reset buffer')
				map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Stage selection')
				map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Reset selection')

				-- Blame & diff
				map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Blame line')
				map('n', '<leader>tb', gs.toggle_current_line_blame, 'Toggle inline blame')
				map('n', '<leader>hd', gs.diffthis,                  'Diff vs index')
				map('n', '<leader>hD', function() gs.diffthis('~') end, 'Diff vs last commit')

				-- Text object: operate on a hunk (e.g. `dih` to delete hunk, `vih` to select)
				map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Inner hunk')
			end,
		},
	},
}
