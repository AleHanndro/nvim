---@type vim.lsp.Config
return {
  init_options = { provideFormatter = false },
  settings = {
    json = {
      validate = { enable = true },
    },
  },
  before_init = function(_, client_config)
    ---@diagnostic disable-next-line: inject-field
    client_config.settings.json.schemas = require("schemastore").json.schemas()
  end,
}
