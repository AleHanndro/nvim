require "configs.lazy"

require "options"
require "autocmds"
vim.schedule(function() require "keymaps" end)

-- vim: ts=2 sts=2 sw=2 et
