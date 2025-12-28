return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "SmiteshP/nvim-navic" },
    config = function()
      vim.lsp.set_log_level("debug")

      -- Hover con borde redondeado
      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { 
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"  -- Matches gruvbox-material popup styles
        })

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
      -- Add lspkind for icons (install via plugin manager if needed)
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- Add lspkind for kind icons
      local lspkind = require("lspkind")

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert,noselect" },
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "path" },
        }),
        -- Enhanced window config with custom borders and colors matching gruvbox-material
        window = {
					completion = cmp.config.window.bordered({
						border = "rounded",  -- Rounded borders for a modern look
						winhighlight = "Normal:Pmenu,FloatBorder:Normal,CursorLine:Pmenu,Search:None",  -- Updated: CursorLine now matches Pmenu for uniform colors
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:Pmenu,FloatBorder:Normal,CursorLine:Pmenu,Search:None",  -- Updated: Same here
					}),
        },
        -- Add formatting with icons and source abbreviations
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",  -- Show icon + text
            maxwidth = 50,         -- Limit width to prevent overflow
            ellipsis_char = "...", -- Truncate long items
            menu = {
              buffer = "[Buf]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              path = "[Path]",
            },
            -- Custom symbol map for better icons (adjust to taste)
            symbol_map = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "󰏗",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "󰒻",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "󰊄",
            },
          }),
        },
        -- Optional: Add experimental ghost text for inline previews
        experimental = {
          ghost_text = true,
        },
        -- window = {
        --   completion = cmp.config.window.bordered(),
        --   documentation = cmp.config.window.bordered(),
        -- },
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
