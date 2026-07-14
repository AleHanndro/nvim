---@module 'blink-cmp'
---@type blink.cmp.Config
return {
  snippets = { preset = "luasnip" },
  cmdline = { enabled = false },
  appearance = { nerd_font_variant = "normal" },
  fuzzy = { implementation = "prefer_rust" },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
    },
  },

  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<C-k>"] = {}, -- C-k is mapped to <Up> on insert mode
    ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
  },

  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
    list = {
      selection = { preselect = false, auto_insert = true },
    },
  },

  signature = { enabled = true },
}
