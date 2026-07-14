return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  ---@module 'catppuccin'
  ---@type CatppuccinOptions
  opts = {
    flavour = "mocha",
    no_italic = true, -- delete or set to false if font have native italics
    term_colors = true,
    -- only enable required integrations
    default_integrations = false,
    integrations = {
      blink_cmp = true,
      fidget = true,
      flash = true,
      fzf = true,
      gitsigns = true,
      grug_far = true,
      mason = true,
      mini = { enabled = true },
      neotree = true,
      snacks = { enabled = true, indent_scope_color = "red" },
      which_key = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme "catppuccin-nvim"
  end,
}
