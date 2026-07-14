---@type LazySpec[]
return {
  "b0o/schemastore.nvim",

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

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = { winblend = 0 },
      },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      integrations = { cmp = false },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    version = "^9",
    init = function()
      ---@module 'rustaceanvim'
      ---@type rustaceanvim.Config
      vim.g.rustaceanvim = {
        ---@type rustaceanvim.lsp.ClientConfig
        server = {
          standalone = false,
          on_attach = function(_, bufnr)
            vim.keymap.set(
              "n",
              "gra",
              function() vim.cmd.RustLsp "codeAction" end,
              { desc = "LSP: goto code action", silent = true, buffer = bufnr }
            )

            vim.keymap.set(
              "n",
              "K",
              function() vim.cmd.RustLsp { "hover", "actions" } end,
              { silent = true, buffer = bufnr }
            )
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { features = "all", targetDir = true },
            },
          },
        },
        ---@type rustaceanvim.dap.Config
        dap = { autoload_configurations = false },
      }
    end,
  },
}
