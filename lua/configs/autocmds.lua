local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
  callback = function(args)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
    end

    map("grn", vim.lsp.buf.rename, "rename")
    map("gra", vim.lsp.buf.code_action, "goto code action", { "n", "x" })
    map("grD", vim.lsp.buf.declaration, "goto declaration")

    map("gri", "<cmd>FzfLua lsp_implementations<CR>", "goto implementation")
    map("grr", "<cmd>FzfLua lsp_references<CR>", "goto references")
    map("grt", "<cmd>FzfLua lsp_typedefs<CR>", "goto type definition")
    map("gO", "<cmd>FzfLua lsp_document_symbols<CR>", "open document symbols")
    map("gW", "<cmd>FzfLua lsp_workspace_symbols<CR>", "open workspace symbols")

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight", args.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup("custom-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("custom-lsp-detach", { clear = true }),
        callback = function(args2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "custom-lsp-highlight", buffer = args2.buf }
        end,
      })
    end

    if client and client:supports_method("textDocument/inlayHint", args.buf) then
      map(
        "<leader>th",
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf }) end,
        "Toggle Inlay Hints"
      )
    end
  end,
})

autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("custom-lint", { clear = true }),
  callback = function()
    if vim.bo.modifiable then require("lint").try_lint() end
  end,
})

-- highlight when yanking (copying) text
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
