return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "onsails/lspkind.nvim",
      { "xzbdmw/colorful-menu.nvim", opts = {} },
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
    },
    event = { "InsertEnter", "CmdLineEnter" },
    opts = function()
      local lspkind = require "lspkind"
      local colorful_menu = require "colorful-menu"
      local mini_icons = require "mini.icons"

      local unknown_types = {
        link = true,
        socket = true,
        fifo = true,
        char = true,
        block = true,
        unknown = true,
      }

      --- @param ctx blink.cmp.DrawItemContext
      local function path_icon(ctx)
        local type = ctx.item.data.type
        local unknown = unknown_types[type]
        local icon, hl = mini_icons.get(unknown and "os" or type, unknown and "" or ctx.label)

        return icon or ctx.kind_icon, icon and hl or ctx.kind_hl
      end

      ---@module 'blink-cmp'
      ---@type blink.cmp.Config
      return {
        appearance = { nerd_font_variant = "normal" },
        cmdline = { enabled = true },
        fuzzy = { implementation = "prefer_rust" },
        signature = { enabled = false },
        snippets = { preset = "luasnip" },
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
            auto_show = true,
            auto_show_delay_ms = 500,
            window = { border = "single" },
          },
          list = {
            selection = { preselect = false, auto_insert = true },
          },

          menu = {
            scrollbar = false,
            border = "single",
            draw = {
              columns = { { "kind_icon" }, { "label", gap = 1 } },
              components = {
                kind_icon = {
                  text = function(ctx)
                    if ctx.source_name == "Path" then
                      local icon = path_icon(ctx)
                      return icon
                    end

                    return lspkind.symbol_map[ctx.kind] or ctx.kind_icon
                  end,
                  highlight = function(ctx)
                    if ctx.source_name == "Path" then
                      local _, hl = path_icon(ctx)
                      return hl
                    end

                    return ctx.kind_hl
                  end,
                },
                label = {
                  text = function(ctx) return colorful_menu.blink_components_text(ctx) end,
                  highlight = function(ctx) return colorful_menu.blink_components_highlight(ctx) end,
                },
              },
            },
          },
        },
      }
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "windwp/nvim-ts-autotag",
    event = "User FilePost",
    opts = {},
  },
}
