---@type vim.lsp.Config
return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- delegate to ruff
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}
