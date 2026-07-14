require "configs.lazy"

require "configs.options"
require "configs.autocmds"
vim.schedule(function() require "configs.keymaps" end)

-- vim: ts=2 sts=2 sw=2 et
