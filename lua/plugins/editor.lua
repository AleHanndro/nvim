---@type LazySpec[]
return {
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
        desc = "Search & Replace",
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

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ---@module 'gitsigns'
    ---@type Gitsigns.Config|{}
    opts = {
      signs = {
        add = { text = "┃" }, ---@diagnostic disable-line: missing-fields
        change = { text = "┃" }, ---@diagnostic disable-line: missing-fields
        delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
        topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
        changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
        untracked = { text = "┆" }, ---@diagnostic disable-line: missing-fields
      },

      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        ---@param mode string|string[]
        ---@param lhs string
        ---@param rhs string|function
        ---@param opts vim.keymap.set.Opts?
        local map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          ---@diagnostic disable-next-line: inject-field
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        map("n", "}c", function()
          if vim.wo.diff then
            vim.cmd.normal { "}c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end, { desc = "Jump to the next git change" })

        map("n", "{c", function()
          if vim.wo.diff then
            vim.cmd.normal { "{c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end, { desc = "Jump to previous git change" })

        -- Actions
        -- visual mode
        map(
          "v",
          "<leader>hs",
          function() gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          { desc = "git stage hunk" }
        )
        map(
          "v",
          "<leader>hr",
          function() gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          { desc = "git reset hunk" }
        )
        -- normal mode
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git stage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git reset hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git stage buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git reset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git preview hunk" })
        map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "git preview hunk inline" })
        map("n", "<leader>hb", function() gitsigns.blame_line { full = true } end, { desc = "git blame line" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "git diff against index" })
        map("n", "<leader>hD", function() gitsigns.diffthis "@" end, { desc = "git diff against last commit" })
        map(
          "n",
          "<leader>hQ",
          function() gitsigns.setqflist "all" end,
          { desc = "git hunk quickfix list (all files in repo)" }
        )
        map("n", "<leader>hq", gitsigns.setqflist, { desc = "git hunk quickfix list (all changes in this file)" })
        -- toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle git show blame line" })
        map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "toggle git intra-line word diff" })

        -- text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
      end,
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = { signs = false },
  },
}
