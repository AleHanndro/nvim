---@type vim.lsp.Config
return {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemaStore = {
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      validate = true,
      format = { enable = false }, -- delegate to conform.nvim
    },
  },
  before_init = function(_, client_config)
    ---@diagnostic disable-next-line: inject-field
    client_config.settings.yaml.schemas = require("schemastore").yaml.schemas() -- lazy load schemas loading
  end,
}
