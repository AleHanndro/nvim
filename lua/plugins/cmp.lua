return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "onsails/lspkind.nvim",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = "rafamadriz/friendly-snippets",
        opts = {
          exit_roots = false,
          keep_roots = true,
          link_children = true,
          link_roots = true,
          update_events = { "TextChanged", "TextChangedI" },
        },
        config = function(_, opts)
          local luasnip = require "luasnip"

          luasnip.config.set_config(opts)

          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_lua").lazy_load()

          -- see: https://github.com/L3MON4D3/LuaSnip/issues/258
          vim.api.nvim_create_autocmd("InsertLeave", {
            group = vim.api.nvim_create_augroup("luasnip-unlink", { clear = true }),
            desc = "Unlink active LuaSnip snippet on InsertLeave",
            callback = function(args)
              if luasnip.session.current_nodes[args.buf] and not luasnip.session.jump_active then
                luasnip.unlink_current()
              end
            end,
          })
        end,
      },
      {
        "nvim-mini/mini.pairs",
        opts = {
          modes = { insert = true, command = true, terminal = false },
          -- skip autopair when next character is one of these
          skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
          -- skip autopair when the cursor is inside these treesitter nodes
          skip_ts = { "string" },
          -- skip autopair when next character is closing pair
          -- and there are more closing pairs than opening pairs
          skip_unbalanced = true,
          -- better deal with markdown code blocks
          markdown = true,
        },
      },
      {
        "windwp/nvim-ts-autotag",
        opts = {},
      },
    },
    event = "InsertEnter",
    opts = function()
      local unknown_types = {
        "link",
        "socket",
        "fifo",
        "char",
        "block",
        "unknown",
      }

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
        },

        completion = {
          documentation = {
            auto_show = false,
            auto_show_delay_ms = 500,
            window = { border = "single", scrollbar = false },
          },
          list = {
            selection = { preselect = false, auto_insert = true },
          },

          menu = {
            scrollbar = false,
            border = "single",
            draw = {
              columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
              components = {
                kind_icon = {
                  text = function(ctx)
                    if ctx.source_name ~= "Path" then
                      return (require("lspkind").symbol_map[ctx.kind] or "") .. ctx.icon_gap
                    end

                    local is_unknown_type = vim.tbl_contains(unknown_types, ctx.item.data.type)
                    local mini_icon, _ = require("mini.icons").get(
                      is_unknown_type and "os" or ctx.item.data.type,
                      is_unknown_type and "" or ctx.label
                    )

                    return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
                  end,
                  highlight = function(ctx)
                    if ctx.source_name ~= "Path" then return ctx.kind_hl end

                    local is_unknown_type = vim.tbl_contains(unknown_types, ctx.item.data.type)
                    local mini_icon, mini_hl = require("mini.icons").get(
                      is_unknown_type and "os" or ctx.item.data.type,
                      is_unknown_type and "" or ctx.label
                    )

                    return mini_icon ~= nil and mini_hl or ctx.kind_hl
                  end,
                },
              },
            },
          },
        },

        signature = { enabled = true },
      }
    end,
  },
}
