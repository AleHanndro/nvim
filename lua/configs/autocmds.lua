local api = vim.api
local map = vim.keymap.set

api.nvim_create_autocmd("LspAttach", {
  group = api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
  callback = function(args)
    local function opts(desc) return { buffer = args.buf, desc = "LSP: " .. desc } end

    map("n", "gd", function() Snacks.picker.lsp_definitions() end, opts "Goto Definition")
    map("n", "gD", function() Snacks.picker.lsp_declarations() end, opts "Goto Declaration")
    map("n", "gri", function() Snacks.picker.lsp_implementations() end, opts "Goto Implementation")
    map("n", "grr", function() Snacks.picker.lsp_references() end, opts "References")
    map("n", "grt", function() Snacks.picker.lsp_type_definitions() end, opts "Goto Type Definition")
    map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, opts "Symbols")
    map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, opts "Workspace Symbols")

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight", args.buf) then
      local highlight_augroup = api.nvim_create_augroup("custom-lsp-highlight", { clear = false })
      api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      api.nvim_create_autocmd("LspDetach", {
        group = api.nvim_create_augroup("custom-lsp-detach", { clear = true }),
        callback = function(args2)
          vim.lsp.buf.clear_references()
          api.nvim_clear_autocmds { group = "custom-lsp-highlight", buffer = args2.buf }
        end,
      })
    end

    if client and client:supports_method("textDocument/inlayHint", args.buf) then
      map(
        "n",
        "<leader>th",
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf }) end,
        opts "Toggle Inlay hints"
      )
    end
  end,
})

api.nvim_create_autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  desc = "Emit User FilePost after UIEnter with a file buffer",
  callback = function(args)
    if args.event == "UIEnter" then vim.g.ui_entered = true end

    if not vim.g.ui_entered then return end
    if not api.nvim_buf_is_valid(args.buf) then return end
    if api.nvim_buf_get_name(args.buf) == "" or vim.bo[args.buf].buftype ~= "" then return end

    api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })

    vim.schedule(function()
      if not api.nvim_buf_is_valid(args.buf) then return end

      local ft = vim.bo[args.buf].filetype
      if ft ~= "" then
        api.nvim_buf_call(
          args.buf,
          function() api.nvim_exec_autocmds("FileType", { pattern = ft, modeline = false }) end
        )
      end
    end)

    return true
  end,
})

api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = api.nvim_create_augroup("custom-lint", { clear = true }),
  callback = function()
    if vim.bo.modifiable then require("lint").try_lint() end
  end,
})

-- highlight when yanking (copying) text
api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
