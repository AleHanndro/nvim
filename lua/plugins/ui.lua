---@type LazySpec[]
return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = {},
      indent = { enabled = true, animate = { enabled = false } },
      picker = {},
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          {
            "diagnostics",
            symbols = { error = "󰅙 ", warn = " ", info = "󰋼 ", hint = "󰌵 " },
          },
        },
        lualine_c = { "filename" },
        lualine_x = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "encoding", separator = "" },
        },
        lualine_y = {},
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    opts = function()
      ---@module 'bufferline'
      ---@type bufferline.UserConfig
      return {
        options = {
          mode = "buffers",
          themable = true,
          offsets = {
            { filetype = "neo-tree" },
          },
        },
        highlights = require("catppuccin.special.bufferline").get_theme(),
      }
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)

      -- ensure bufferline updates immediately when restoring sessions
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function() pcall(nvim_bufferline) end)
        end,
      })
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
}
