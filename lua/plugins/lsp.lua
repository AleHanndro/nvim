---@type LazySpec[]
return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "single",
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
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

      vim.lsp.config("*", { capabilities = capabilities })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = "User FilePost",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "basedpyright", -- python
        "bashls", -- bash/csh/ksh/sh/zsh
        "dockerls", -- dockerfile
        "eslint", -- eslint lint
        "jsonls", -- json/jsonc/json5
        "just", -- justfile
        "lua_ls", -- lua
        "rumdl", -- markdown lint
        "tombi", -- toml
        "vtsls", -- typescript/javascript/tsx/jsx/...
        "yamlls", -- yaml
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- There are LSP servers that should be installed under certain conditions.
      -- For example, they should match the installed version of the current
      -- toolchain/compiler (e.g. rust_analyzer, zls). These LSPs are easier to manage
      -- with external version managers (e.g. rustup or mise) than with Mason.
      vim.lsp.enable { "zls" }
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
