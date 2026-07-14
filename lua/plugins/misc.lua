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
    opts = function() return require "configs.lualine" end,
  },

  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = { n_lines = 500 },
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = { signs = false },
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
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      {
        "<leader>sf",
        function()
          FzfLua.files {
            actions = {
              ["ctrl-i"] = { FzfLua.actions.toggle_ignore },
              ["ctrl-h"] = { FzfLua.actions.toggle_hidden },
            },
          }
        end,
        desc = "search files",
      },
      { "<leader><leader>", "<cmd>FzfLua buffers<CR>", desc = "search open buffers" },
      { "<leader>sk", "<cmd>FzfLua keymaps<CR>", desc = "search keymaps" },
      { "<leader>sh", "<cmd>FzfLua helptags<CR>", desc = "search help" },
      {
        "<leader>sg",
        function()
          FzfLua.lgrep_curbuf {
            actions = {
              ["ctrl-g"] = false,
              ["ctrl-t"] = { FzfLua.actions.grep_lgrep },
            },
          }
        end,
        desc = "search by grep on current buffer",
      },
      {
        "<leader>sG",
        function()
          FzfLua.live_grep {
            actions = {
              ["ctrl-g"] = false,
              ["ctrl-t"] = { FzfLua.actions.grep_lgrep },
              ["ctrl-i"] = { FzfLua.actions.toggle_ignore },
              ["ctrl-h"] = { FzfLua.actions.toggle_hidden },
            },
          }
        end,
        desc = "search by grep current project",
      },
    },
    ---@module 'fzf-lua'
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {
      { "fzf-native" },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = { "GrugFar", "GrugFarWithin" },
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require "grug-far"
          local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"

          grug.open {
            transient = true,
            prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil },
          }
        end,
        mode = { "n", "x" },
        desc = "search and replace",
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Treesitter Search",
      },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      {
        "<c-space>",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter {
            actions = {
              ["<c-space>"] = "next",
              ["<BS>"] = "prev",
            },
          }
        end,
        desc = "Treesitter Incremental Selection",
      },
    },
  },
}
