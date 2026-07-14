---@type LazySpec[]
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        mode = { "n", "x" },
        "<leader>fm",
        function() require("conform").format { async = false } end,
        desc = "Format buffer",
      },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = { timeout_ms = 500, lsp_format = "fallback", async = false },
      default_format_opts = { lsp_format = "fallback" },

      formatters = {
        rumdl = {
          prepend_args = {
            "--config",
            'global.disable = ["MD034", "MD036", "MD040"]',
            "--config",
            "MD013.line-length = 80",
            "--config",
            "MD013.reflow = true",
          },
        },
        yamlfmt = {
          prepend_args = { "-formatter", "retain_line_breaks_single=true", "-formatter", "pad_line_comments=2" },
        },
      },

      formatters_by_ft = {
        dependabot = { "yamlfmt" },
        gha = { "yamlfmt" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        lua = { "stylua" },
        markdown = { "rumdl" },
        rust = { "rustfmt" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        yaml = { "yamlfmt" },
      },
    },
  },
}
