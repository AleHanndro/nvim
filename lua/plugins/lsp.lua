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

      local x = vim.diagnostic.severity
      vim.diagnostic.config {
        update_in_insert = false,
        severity_sort = true,
        virtual_text = false,
        signs = {
          text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" },
        },
        float = { border = "single" },
        underline = {
          severity = { min = x.WARN },
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "plaintext", "markdown" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits" },
        },
      }

      vim.lsp.config("*", { capabilities = capabilities })

      local servers = {
        "basedpyright",
        "dockerls",
        "jsonls",
        "just",
        "lua_ls",
        "rumdl",
        "tombi",
        "yamlls",
      }

      vim.lsp.enable(servers)
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    opts = {
      options = {
        show_source = { if_many = true },
        use_icons_from_diagnostic = true,
        experimental = { use_window_local_extmarks = true },
      },
    },
  },
}
