return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  ---@module 'catppuccin'
  ---@type CatppuccinOptions
  opts = {
    flavour = "auto",
    -- only enable required integrations
    auto_integrations = false,
    integrations = {
      blink_cmp = true,
      fidget = true,
      flash = true,
      gitsigns = true,
      grug_far = true,
      mason = true,
      mini = { enabled = true },
      snacks = { enabled = true, indent_scope_color = "red" },
      which_key = true,
    },
    custom_highlights = function(colors)
      return {
        BlinkCmpKindEnumMember = { fg = colors.red },
        BlinkCmpLabelMatch = { style = { "bold" } },
        BlinkCmpMenu = { bg = colors.base },
        BlinkCmpMenuBorder = { bg = colors.base, fg = colors.blue },
        BlinkCmpDoc = { bg = colors.base },
        BlinkCmpDocBorder = { bg = colors.base, fg = colors.blue },
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme "catppuccin-nvim"
  end,
}
