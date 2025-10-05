-- return {
-- 	{
-- 		"nvim-lualine/lualine.nvim",
-- 		dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
-- 		opts = {
-- 			options = {
-- 				theme                = "auto",
-- 				disabled_filetypes   = {
-- 					statusline = { "alpha" },
-- 					tabline = { "alpha" },
-- 					winbar = { "alpha" }
-- 				},
-- 				component_separators = { left = '', right = '' }, -- separadores internos
-- 				section_separators   = { left = '', right = '' }, -- bordes redondeados/triangulares
-- 				icons_enabled        = true,
-- 			},
-- 			-- tabline = {
-- 			-- 	lualine_a = { 'buffers' }
-- 			-- },
-- 			sections = {
-- 				lualine_a = { 'mode' },                           -- NORMAL / INSERT / VISUAL
-- 				lualine_b = { 'branch', 'diff', 'diagnostics' },  -- git branch + diffs + errores
-- 				lualine_c = { { 'filename', path = 1 } },         -- nombre del archivo
-- 				lualine_x = { 'encoding', 'fileformat', 'filetype' }, -- UTF-8, Unix, rust, etc.
-- 				lualine_y = { 'progress' },                       -- % dentro del archivo
-- 				lualine_z = { 'location' }                        -- línea y columna
-- 			},
-- 		},
-- 		config = function(_, opts)
-- 			require("lualine").setup(opts)
-- 		end
-- 	}, {
-- 	"norcalli/nvim-colorizer.lua",
-- 	config = function()
-- 		require('colorizer').setup()
-- 	end
-- }, {
-- 	"lukas-reineke/indent-blankline.nvim",
-- 	main = "ibl",
-- 	opts = {},
-- 	config = function()
-- 		require("ibl").setup()
-- 	end
-- }, {
-- 	'akinsho/bufferline.nvim',
-- 	requires = 'nvim-tree/nvim-web-devicons',
-- 	config = function()
-- 		require("bufferline").setup {}
-- 	end
-- },
-- 	{
-- 		'SmiteshP/nvim-navic',
-- 		requires = 'neovim/nvim-lspconfig',
-- 		config = function()
-- 			require("nvim-navic").setup {
-- 				highlight = true, -- colorea según el tema
-- 				separator = "  ", -- el separador entre símbolos (elige el que te guste)
-- 				depth_limit = 5, -- evita breadcrumbs kilométricos
-- 				safe_output = true,
-- 				icons = {
-- 					File = "󰈙 ", Module = "󰏗 ", Namespace = "󰌗 ", Package = "󰏓 ",
-- 					Class = "󰠱 ", Method = "󰆧 ", Property = "󰜢 ", Field = "󰇽 ",
-- 					Constructor = " ", Enum = "󰒻 ", Interface = " ", Function = "󰊕 ",
-- 					Variable = "󰀫 ", Constant = "󰏿 ", String = "󰉿 ", Number = "󰎠 ",
-- 					Boolean = " ", Array = "󰅪 ", Object = " ", Key = "󰌋 ",
-- 					Null = "󰟢 ", EnumMember = " ", Struct = "󰙅 ", Event = " ",
-- 					Operator = "󰆕 ", TypeParameter = "󰊄 ",
-- 				},
-- 			}
-- 		end
-- 	}
-- }

return {





	{
		-- LUALINE estilo "Eviline" adaptado a Lazy + tu config
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local lualine = require("lualine")

			-- Paleta
			local colors = {
				bg       = '#16161D',
				fg       = '#bbc2cf',
				yellow   = '#ECBE7B',
				cyan     = '#008080',
				darkblue = '#081633',
				green    = '#98be65',
				orange   = '#FF8800',
				violet   = '#a9a1e1',
				magenta  = '#c678dd',
				blue     = '#51afef',
				red      = '#ec5f67',
			}

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand('%:p:h')
					local gitdir = vim.fn.finddir('.git', filepath .. ';')
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			-- Config base Eviline
			local config = {
				options = {
					component_separators = '',
					section_separators   = '',
					globalstatus         = true,
					theme                = {
						normal   = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
					disabled_filetypes   = {
						statusline = { "alpha" },
						tabline    = { "alpha" },
						winbar     = { "alpha" },
					},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {}, -- se llenan abajo
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
				extensions = { "quickfix", "man", "fugitive", "neo-tree", "nvim-tree", "lazy" },
			}

			-- Helpers Eviline
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			-- ► Left
			ins_left {
				function() return '▊' end,
				color = { fg = colors.blue },
				padding = { left = 0, right = 1 },
			}


			ins_left {
				function()
					local mode_icons = {
						n     = "󰋇 N", -- Normal
						i     = "󰏫 I", -- Insert
						v     = "󰈈 V", -- Visual
						V     = "󰈈 V", -- Visual Line
						[""] = "󰈈 V", -- Visual Block
						c     = "󰘳 C", -- Command
						R     = "󰑖 R", -- Replace
						t     = " T", -- Terminal
					}
					return mode_icons[vim.fn.mode()] or "?"
				end,
				color = function()
					local colors = {
						n = "#ec5f67", -- rojo para normal
						i = "#98be65", -- verde para insert
						v = "#51afef", -- azul para visual
						V = "#51afef",
						[""] = "#51afef",
						c = "#c678dd",
						R = "#a9a1e1",
						t = "#ec5f67",
					}
					return { fg = colors[vim.fn.mode()] or "#ffffff" }
				end,
				padding = { right = 1 },
			}

			ins_left { 'filesize', cond = conditions.buffer_not_empty }

			-- 🔥 Icono del archivo (coloreado) + RUTA ABSOLUTA
			ins_left { 'filetype', icon_only = true, colored = true, padding = { left = 1, right = 0 } }
			ins_left {
				'filename',
				path = 1, -- ruta ABSOLUTA
				cond = conditions.buffer_not_empty,
				color = { fg = colors.blue, gui = 'bold' },
				symbols = { modified = ' ', readonly = ' ', unnamed = '[No Name]' },
				padding = { left = 0, right = 1 },
			}

			-- Breadcrumb con navic (función/clase actual)
			ins_left {
				function()
					local ok, navic = pcall(require, "nvim-navic")
					if ok and navic.is_available() then
						return navic.get_location()
					end
					return ''
				end,
				cond = function()
					local ok, navic = pcall(require, "nvim-navic")
					return ok and navic.is_available()
				end,
				color = { fg = colors.orange },
				padding = { left = 1, right = 1 },
			}

			ins_left { 'location' }
			ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

			ins_left {
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				symbols = { error = ' ', warn = ' ', info = ' ' },
				diagnostics_color = {
					error = { fg = colors.red },
					warn  = { fg = colors.yellow },
					info  = { fg = colors.cyan },
				},
			}

			-- Separador central
			ins_left { function() return '%=' end }

			-- Nombre del LSP activo
			ins_left {
				function()
					local msg = 'No Active Lsp'
					local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
					for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
						local fts = client.config and client.config.filetypes
						if fts and vim.tbl_contains(fts, buf_ft) then
							return client.name
						end
					end
					return msg
				end,
				icon = ' LSP:',
				color = { fg = '#ffffff', gui = 'bold' },
			}

			-- ► Right
			ins_right {
				'o:encoding',
				fmt = string.upper,
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = 'bold' },
			}

			ins_right {
				'fileformat',
				fmt = string.upper,
				icons_enabled = false,
				color = { fg = colors.green, gui = 'bold' },
			}

			ins_right {
				'branch',
				icon = '',
				color = { fg = colors.violet, gui = 'bold' },
				cond = conditions.check_git_workspace,
			}

			ins_right {
				'diff',
				symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
				diff_color = {
					added    = { fg = colors.green },
					modified = { fg = colors.orange },
					removed  = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			}

			ins_right {
				function() return '▊' end,
				color = { fg = colors.blue },
				padding = { left = 1 },
			}

			return config
		end,
		config = function(_, opts)
			vim.opt.laststatus = 3
			require('lualine').setup(opts)
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup()
		end,
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},

	-- navic ya lo tienes, lo dejamos igual (solo aseguramos que está cargado antes de lualine arriba)
	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("nvim-navic").setup({
				highlight = false,
				separator = "  ",
				depth_limit = 2,
				safe_output = true,
				icons = {
					File = "󰈙 ",
					Module = "󰏗 ",
					Namespace = "󰌗 ",
					Package = "󰏓 ",
					Class = "󰠱 ",
					Method = "󰆧 ",
					Property = "󰜢 ",
					Field = "󰇽 ",
					Constructor = " ",
					Enum = "󰒻 ",
					Interface = " ",
					Function = "󰊕 ",
					Variable = "󰀫 ",
					Constant = "󰏿 ",
					String = "󰉿 ",
					Number = "󰎠 ",
					Boolean = " ",
					Array = "󰅪 ",
					Object = " ",
					Key = "󰌋 ",
					Null = "󰟢 ",
					EnumMember = " ",
					Struct = "󰙅 ",
					Event = " ",
					Operator = "󰆕 ",
					TypeParameter = "󰊄 ",
				},
			})
		end,
	},
}
