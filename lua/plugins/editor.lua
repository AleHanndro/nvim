---@type LazySpec[]
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    keys = {
      { "<C-n>", "<cmd>Neotree toggle<CR>", desc = "Toggle neo-tree" },
      { "<leader>e", "<cmd>Neotree focus<CR>", desc = "Focus neo-tree" },
    },
    opts = function()
      local on_move = function(data) Snacks.rename.on_rename_file(data.source, data.destination) end
      local events = require "neo-tree.events"

      ---@module 'neo-tree'
      ---@type neotree.Config
      return {
        sources = { "filesystem", "git_status" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf" },
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        default_component_configs = {
          indent = {
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
          },
          git_status = {
            symbols = { unstaged = "󰄱", staged = "󰱒" },
          },
        },
        event_handlers = {
          { event = events.FILE_MOVED, handler = on_move },
          { event = events.FILE_RENAMED, handler = on_move },
        },
      }
    end,
  },
}
