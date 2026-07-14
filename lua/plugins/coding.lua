---@type LazySpec[]
return {
  "b0o/schemastore.nvim",

  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = { n_lines = 500 },
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
