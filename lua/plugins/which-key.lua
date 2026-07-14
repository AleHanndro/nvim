---@type LazySpec[]
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      -- delay between pressing a key and opening a which-key (milliseconds)
      delay = 0,
      spec = {
        { "gr", group = "LSP Actions", mode = { "n" } },
        { "<leader>h", group = "Git Hunk", mode = { "n", "v" } },
        { "<leader>s", group = "Search", mode = { "n", "v" } },
        { "<leader>t", group = "Toggle", mode = { "n" } },
      },
    },
  },
}
