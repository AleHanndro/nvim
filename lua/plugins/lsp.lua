---@type LazySpec[]
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "actionlint", -- yaml (github actions)
        "basedpyright", -- python
        "dockerfile-language-server", -- docker, lsp: dockerls
        "hadolint", -- docker
        "json-lsp", -- json, lsp: jsonls
        "just-lsp", -- justfile, lsp: just
        "lua-language-server", -- lua, lsp: lua_ls
        "rumdl", -- markdown format/linter
        "stylua", -- lua
        "tombi", -- toml lsp/linter/formatter, lsp: tombi
        "yaml-language-server", -- yaml, lsp: yamlls
        "yamlfmt", -- yaml
        "yamllint", -- yaml
      },
    },
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
      require "configs.lspconfig"
    end,
  },
}
