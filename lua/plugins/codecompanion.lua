--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
return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			adapters = {
				http = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								-- default = "claude-3.5-sonnet",
								-- default = ["o3-mini-2025-01-31"] = { opts = { can_reason = true } },
								-- default = ["o1-2024-12-17"] = { opts = { can_reason = true } },
								-- default = ["o1-mini-2024-09-12"] = { opts = { can_reason = true } },
								-- default = "gpt-4o-2024-08-06",
								default = "claude-sonnet-4",
								-- default = "gpt-5"
							},
						},
						opts = {
							stream = true,
						},
					})
				end,
			}
			},
			strategies = {
				chat = {
					adapter = "copilot",
					slash_commands = {
						["file"] = {
							-- Location to the slash command in CodeCompanion
							callback = "strategies.chat.slash_commands.file",
							description = "Select a file using Telescope",
							opts = {
								provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
								contains_code = true,
							},
						},
					},
					keymaps = {
						close = {
							modes = { n = "<C-o>", i = "<C-o>" },
						},
						-- Add further custom keymaps here
					},
					-- Change the default icons
					icons = {
						pinned_buffer = " ",
						watched_buffer = "👀 ",
					},

					-- Alter the sizing of the debug window
					debug_window = {
						---@return number|fun(): number
						width = vim.o.columns - 5,
						---@return number|fun(): number
						height = vim.o.lines - 2,
					},

					-- Options to customize the UI of the chat buffer
					window = {
						layout = "vertical", -- float|vertical|horizontal|buffer
						position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
						border = "single",
						height = 0.8,
						width = 0.15,
						opts = {
							breakindent = true,
							cursorcolumn = false,
							cursorline = false,
							foldcolumn = "0",
							linebreak = true,
							list = false,
							numberwidth = 1,
							signcolumn = "no",
							spell = false,
							wrap = true,
						},
					},
				},
				inline = {
					adapter = "copilot",
				},
				agent = {
					adapter = "copilot",
				},
				workflow = {
					adapter = "copilot",
				},
			},
			display = {
				action_palette = {
					width = 95,
					height = 10,
					provider = "telescope", -- default|telescope|mini_pick
					opts = {
						show_default_actions = true, -- Show the default actions in the action palette?
						show_default_prompt_library = true, -- Show the default prompt library in the action palette?
					},
				},
			},
		},
		config = function(_, opts)
			require("codecompanion").setup(opts)
			vim.keymap.set("n", "<leader>l", ":CodeCompanionChat <CR>")
			vim.keymap.set("v", "<leader>l", ":'<,'>CodeCompanionChat<CR>")
			vim.keymap.set("n", "<leader>i", ":CodeCompanionActions <CR>")
			vim.keymap.set("v", "<leader>i", ":'<,'>CodeCompanionActions<CR>")
			vim.keymap.set("v", "<leader>o", ":'<,'>CodeCompanion<CR>")
			vim.keymap.set("n", "<leader>o", ":CodeCompanion<CR>")
		end,
	},
}
