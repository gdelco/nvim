-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		config = function()
-- 			local util = require("lspconfig.util")
-- 			vim.lsp.set_log_level("debug")
--
-- 		-- Cambiar borde del hover
-- 		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
-- 			vim.lsp.handlers.hover, {
-- 				border = "rounded", -- opciones: "single", "double", "rounded", "solid", "shadow"
-- 			}
-- 		)
--
-- 			local capabilities =
-- 				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- 			capabilities.workspace = {
-- 				didChangeWatchedFiles = {
-- 					dynamicRegistration = true,
-- 				},
-- 			}
-- 			-- LSP configuration
-- 			local lspconfig = require("lspconfig")
-- 			lspconfig.clangd.setup({})
-- 			lspconfig.gopls.setup({
-- 				on_attach = function(client, bufnr)
-- 					vim.api.nvim_buf_set_option(bufnr, "completeopt", "menu,menuone,noinsert,noselect")
-- 				end,
-- 			})
-- 			lspconfig.cssls.setup({})
-- 			lspconfig.pyright.setup({})
-- 			lspconfig.tailwindcss.setup({})
-- 			lspconfig.cmake.setup({})
-- 			lspconfig.asm_lsp.setup({})
-- 			lspconfig.ruff.setup({})
-- 			lspconfig.rust_analyzer.setup({})
-- 			lspconfig.ts_ls.setup({})
-- 			lspconfig.bashls.setup({})
-- 			lspconfig.docker_compose_language_service.setup({})
-- 			lspconfig.dockerls.setup({})
-- 			lspconfig.jdtls.setup({})
-- 			lspconfig.html.setup({})
-- 			lspconfig.esbonio.setup({})
-- 			lspconfig.emmet_language_server.setup({})
-- 			lspconfig.markdown_oxide.setup({
-- 				capabilities = capabilities,
-- 			})
-- 			lspconfig.lua_ls.setup({
-- 				Lua = {
-- 					diagnostics = {
-- 						globals = {
-- 							"vim",
-- 							"require",
-- 						},
-- 					},
-- 				},
-- 			})
--
-- 			-- Ensure diagnostics appear on screen
-- 			vim.diagnostic.config({
-- 				virtual_text = true,
-- 				signs = true,
-- 				underline = true,
-- 				update_in_insert = false,
-- 				severity_sort = true,
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"williamboman/mason.nvim",
-- 		enable = false,
-- 		config = function()
-- 			require("mason").setup()
-- 		end,
-- 	},
-- 	-- CMP
-- 	{
-- 		"hrsh7th/nvim-cmp",
-- 		dependencies = {
-- 			"neovim/nvim-lspconfig",
-- 			"hrsh7th/cmp-nvim-lsp",
-- 			"hrsh7th/cmp-buffer",
-- 			"hrsh7th/cmp-path",
-- 			"hrsh7th/cmp-cmdline",
-- 			"L3MON4D3/LuaSnip",
-- 			"saadparwaiz1/cmp_luasnip",
-- 		},
-- 		config = function()
-- 			local cmp = require("cmp")
-- 			local luasnip = require("luasnip")
-- 			cmp.setup({
-- 				completion = {
-- 					completeopt = "menu,menuone,noinsert,noselect",
-- 				},
-- 				snippet = {
-- 					expand = function(args)
-- 						require("luasnip").lsp_expand(args.body)
-- 					end,
-- 				},
-- 				sources = cmp.config.sources({
-- 					{ name = "luasnip" },
-- 					{ name = "nvim_lsp" },
-- 					{ name = "path" },
-- 				}),
-- 				mapping = cmp.mapping.preset.insert({
-- 					["<CR>"] = cmp.mapping({
-- 						i = function(fallback)
-- 							if cmp.visible() and cmp.get_active_entry() then
-- 								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
-- 							else
-- 								fallback()
-- 							end
-- 						end,
-- 						s = cmp.mapping.confirm({ select = true }),
-- 						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
-- 					}),
-- 					["<C-l>"] = cmp.mapping(function(fallback)
-- 						if luasnip.expand_or_jumpable() then
-- 							luasnip.expand_or_jump()
-- 						elseif cmp.visible() then
-- 							cmp.select_next_item()
-- 						else
-- 							fallback()
-- 						end
-- 					end, { "i", "s" }),
-- 					["[C-h]"] = cmp.mapping(function(fallback)
-- 						if luasnip.jumpable(-1) then
-- 							luasnip.jump(-1)
-- 						elseif cmp.visible() then
-- 							cmp.select_prev_item()
-- 						else
-- 							fallback()
-- 						end
-- 					end, { "i", "s" }),
-- 					["<C-k>"] = cmp.mapping.scroll_docs(-4),
-- 					["<C-j>"] = cmp.mapping.scroll_docs(4),
-- 					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
-- 				}),
-- 			})
-- 			require("lspconfig").gopls.setup({
-- 				on_attach = function(_, bufnr)
-- 					vim.api.nvim_buf_set_option(bufnr, "completeopt", "menu,menuone,noinsert,noselect")
-- 				end,
-- 			})
-- 			require("luasnip/loaders/from_vscode").lazy_load()
-- 		end,
-- 	},
-- }

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "SmiteshP/nvim-navic" },
    config = function()
      vim.lsp.set_log_level("debug")

      -- Hover con borde redondeado
      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      -- Protegemos el require de navic por si aún no está cargado
      local ok_navic, navic = pcall(require, "nvim-navic")

      -- Capabilities para nvim-cmp
      local capabilities =
        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.workspace = { didChangeWatchedFiles = { dynamicRegistration = true } }

      -- on_attach común (adhiere navic si hay documentSymbolProvider)
      local function on_attach(client, bufnr)
        if ok_navic
          and client.server_capabilities
          and client.server_capabilities.documentSymbolProvider
        then
          navic.attach(client, bufnr)
        end
        pcall(vim.api.nvim_buf_set_option, bufnr, "completeopt", "menu,menuone,noinsert,noselect")
      end

      -- Helper para definir+habilitar servidores con la nueva API
      local function setup(server, opts)
        opts = opts or {}
        opts.on_attach = opts.on_attach or on_attach
        opts.capabilities = opts.capabilities or capabilities
        vim.lsp.config(server, opts)   -- define la config
        vim.lsp.enable(server)         -- habilita el server
      end

      -- === Tus servidores, tal como estaban ===
      setup("clangd")
      setup("gopls")
      setup("cssls")
      setup("pyright")
      setup("tailwindcss")
      setup("cmake")
      setup("asm_lsp")
      setup("ruff")
      setup("rust_analyzer")
      setup("ts_ls") -- si usas 'tsserver', cámbialo a 'tsserver'
      setup("bashls")
      setup("docker_compose_language_service")
      setup("dockerls")
      setup("jdtls")
      setup("html")
      setup("esbonio")
      setup("emmet_language_server")
      setup("markdown_oxide", { capabilities = capabilities })
      setup("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", "require" } },
          },
        },
      })

      -- Diagnósticos (igual que antes)
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },

  -- Mason lo dejas como lo tenías; lo omito si está deshabilitado
  {
    "williamboman/mason.nvim",
    enable = false,
    config = function() require("mason").setup() end,
  },

  -- CMP (tu bloque, sin cambios relevantes)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert,noselect" },
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          }),
          ["<C-l>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["[C-h]"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        }),
      })
      require("luasnip/loaders/from_vscode").lazy_load()
    end,
  },
}
