return {
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
        symbols = { error = " ", warn = " ", info = "󰋼 ", hint = " " },
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
}
