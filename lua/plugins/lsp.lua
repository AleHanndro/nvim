---@type LazySpec[]
return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
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
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "astro", -- astro
        "basedpyright", -- python
        "cssls", -- css/scss/sass
        "dockerls", -- dockerfile
        "emmet_language_server", -- emmet
        "eslint", -- eslint lint
        "jsonls", -- json/jsonc/json5
        "just", -- justfile
        "lua_ls", -- lua
        "rumdl", -- markdown lint
        "superhtml", -- html
        "tailwindcss", -- tailwind support
        "tombi", -- toml
        "vtsls", -- typescript/javascript/tsx/jsx/...
        "yamlls", -- yaml
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        "actionlint", -- yaml (github actions)
        "hadolint", -- docker
        "prettierd", -- html/js/ts/tsx/jsx/...
        "stylua", -- lua
        "yamlfmt", -- yaml
        "yamllint", -- yaml
      },
    },
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
