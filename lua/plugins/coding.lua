---@type LazySpec[]
return {
  "b0o/schemastore.nvim",

  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = { n_lines = 500 },
  },

  {
    "nvim-mini/mini.surround",
    keys = function(self)
      local opts = self.opts or {}
      local m = opts.mappings or {}

      return {
        { m.add, desc = "Add Surrounding", mode = { "n", "x" } },
        { m.delete, desc = "Delete Surrounding" },
        { m.find, desc = "Find Right Surrounding" },
        { m.find_left, desc = "Find Left Surrounding" },
        { m.highlight, desc = "Highlight Surrounding" },
        { m.replace, desc = "Replace Surrounding" },
        { m.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
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
              "K",
              function() vim.cmd.RustLsp { "hover", "actions" } end,
              { silent = true, buffer = bufnr }
            )
          end,
        },
        ---@type rustaceanvim.dap.Config
        dap = { autoload_configurations = false },
      }
    end,
  },
}
