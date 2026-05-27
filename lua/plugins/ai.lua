return {
	-- Shared dependency: snacks provides terminal/input/picker primitives
	-- used by both claudecode.nvim and opencode.nvim.
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			input = {},
			picker = {
				actions = {
					opencode_send = function(...)
						return require("opencode").snacks_picker_send(...)
					end,
				},
				win = {
					input = {
						keys = {
							["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
						},
					},
				},
			},
		},
	},

	-- Claude Code <-> nvim bridge (WebSocket MCP, same protocol as the VS Code extension).
	-- Launch `claude` in any terminal pane while nvim is open; it auto-attaches.
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>ac", "<cmd>ClaudeCode<cr>",             desc = "Toggle Claude" },
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>",        desc = "Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>",    desc = "Resume Claude session" },
			{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>",  desc = "Continue Claude session" },
			{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>",  desc = "Select Claude model" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",        desc = "Add buffer to Claude" },
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>",         mode = "v", desc = "Send selection to Claude" },
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",   desc = "Accept Claude diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",     desc = "Deny Claude diff" },
		},
	},

	-- OpenAI Codex integration via JSON-RPC to `codex app-server`.
	-- Streams replies into a split; context-aware (@this, @buffer, @diagnostics).
	-- Requires the `codex` CLI on PATH.
	{
		"anirudhsundar/codex.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = function()
			vim.g.codex_opts = {}
		end,
		keys = {
			{ "<leader>cc", function() Snacks.terminal.toggle("codex", { win = { position = "float", border = "rounded" } }) end, desc = "Toggle codex CLI" },
			{ "<leader>ca", function() require("codex").ask("@this: ") end,   mode = { "n", "x" }, desc = "Ask codex about current line/selection" },
			{ "<leader>cA", function() require("codex").ask("@buffer: ") end, mode = { "n", "x" }, desc = "Ask codex about whole buffer" },
			{ "<leader>cp", function() require("codex").select() end,         mode = { "n", "x" }, desc = "Codex prompt/command picker" },
		},
	},

	-- opencode (SST's terminal AI agent) integration.
	-- Requires the `opencode` CLI installed on PATH.
	{
		"NickvanDyke/opencode.nvim",
		version = "*",
		dependencies = { "folke/snacks.nvim" },
		config = function()
			vim.g.opencode_opts = {}
		end,
		keys = {
			{ "<leader>oo", function() require("opencode").toggle() end,                         mode = { "n", "t" }, desc = "Toggle opencode" },
			{ "<leader>oa", function() require("opencode").ask("@this: ") end,                    mode = { "n", "x" }, desc = "Ask opencode about current line/selection" },
			{ "<leader>oA", function() require("opencode").ask("@buffer: ") end,                  mode = { "n", "x" }, desc = "Ask opencode about whole buffer" },
			{ "<leader>op", function() require("opencode").select() end,                         mode = { "n", "x" }, desc = "Opencode prompt picker" },
			{ "go",         function() return require("opencode").operator("@this ") end,         mode = { "n", "x" }, expr = true, desc = "Operator: send range to opencode" },
		},
	},
}
