---@type vim.lsp.Config
return {
  settings = {
    codeLens = { enable = false },
    completion = { callSnippet = "Replace" },
    doc = { privateName = { "^_" } },
    hint = {
      enable = true,
      setType = false,
      paramType = true,
      paramName = "Disable",
      semicolon = "Disable",
      arrayIndex = "Disable",
    },
    format = { enable = false }, -- use conform.nvim
  },
}
