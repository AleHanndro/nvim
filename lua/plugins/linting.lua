---@type LazySpec[]
return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        dockerfile = { "hadolint" },
        gha = { "actionlint" },
        markdown = { "rumdl" },
        yaml = { "yamllint" },
      }
    end,
  },
}
