-- LSP Config
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{
		virtual_text = false,
		signs = false,
		update_in_insert = true,
		underline = true,
	}
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded" -- or "rounded", "double"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "single" -- or "rounded", "double"
  }
)


-- Fuerza ejecutar cuando Neovim ya terminó de cargar (plugins incluidos)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local orig = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"
      return orig(contents, syntax, opts, ...)
    end

    -- Si quieres, fija también el handler específico (no necesario si haces lo de arriba)
    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    --   vim.lsp.handlers.hover, { border = "rounded" }
    -- )
  end,
})
