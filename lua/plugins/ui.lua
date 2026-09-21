---@type LazySpec[]
return {
  {
    "nvim-mini/mini.icons",
    version = false,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      indent = { enabled = true, animate = { enabled = false } },
      picker = {},
    },
  },

  {
    "nvim-mini/mini.statusline",
    event = "VeryLazy",
    opts = {},
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
            { filetype = "snacks_layout_box" },
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

  {
    "onsails/lspkind.nvim",
    opts = {
      symbol_map = {
        Array = "  ",
        Boolean = " 󰨙 ",
        Class = " 󰯳 ",
        Codeium = " 󰘦 ",
        Collapsed = " > ",
        Color = " 󰰠 ",
        Constant = " 󰯱 ",
        Constructor = "  ",
        Control = "  ",
        Copilot = "  ",
        Enum = " 󰯹 ",
        EnumMember = " E ",
        Event = "  ",
        Field = "  ",
        File = "  ",
        Folder = "  ",
        Function = " 󰡱 ",
        Interface = " 󰰅 ",
        Key = "  ",
        Keyword = " 󱕴 ",
        Method = " 󰰑 ",
        Module = " 󰆼 ",
        Namespace = " 󰰔 ",
        Null = "  ",
        Number = " 󰰔 ",
        Object = " 󰲟 ",
        Operator = "  ",
        Package = " 󰰚 ",
        Property = " 󰲽 ",
        Reference = " 󰰠 ",
        Snippet = "  ",
        String = "  ",
        Struct = " 󰰣 ",
        TabNine = " 󰏚 ",
        Text = " 󱜥 ",
        TypeParameter = " 󰰦 ",
        Unit = " 󱜥 ",
        Value = "  ",
        Variable = " 󰫧 ",
      },
    },
    config = function(_, opts) require("lspkind").init(opts) end,
  },
}
