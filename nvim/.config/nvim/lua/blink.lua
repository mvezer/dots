return function()
  require("blink.cmp").setup({
    keymap = {
      preset = "default",
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },
    },
    -- completion = {
    --   menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end }
    -- },
    completion = {
      menu = {
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },

      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- snippets = {
    --   expand = function(snippet)
    --     require('luasnip').lsp_expand(snippet)
    --   end,
    --   active = function(filter)
    --     if filter and filter.direction then
    --       return require('luasnip').jumpable(filter.direction)
    --     end
    --     return require('luasnip').in_snippet()
    --   end,
    --   jump = function(direction)
    --     require('luasnip').jump(direction)
    --   end,
    -- },
    sources = {
      default = { "lsp", "path", "buffer" },
    },

    -- experimental signature help support
    signature = { enabled = true },
  })
end
