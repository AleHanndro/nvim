---@type LazySpec[]
return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        dockerfile = { "hadolint" },
        gha = { "actionlint" },
        yaml = { "yamllint" },
      }
    end,
  },
}
