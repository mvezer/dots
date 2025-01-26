return function ()
  require("blink.cmp").setup({
    keymap = { preset = "enter" },
    -- completion = { list = { selection = { preselect = true,  auto_insert = false } } }
    completion = { list = { selection = {
      preselect = function (ctx)
        return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active({ direction = 1 })
      end,
      auto_insert = false,
    } } },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "normal",
    },

    sources = {
      default = { "lsp", "path", "buffer", "obsidian", "obsidian_new", "obsidian_tags" },

      providers = {
        obsidian = { name = "obsidian", module = "blink.compat.source" },
        obsidian_new = { name = "obsidian_new", module = "blink.compat.source" },
        obsidian_tags = { name = "obsidian_tags", module = "blink.compat.source" },
      },

      cmdline = {},
    },

    signature = { enabled = true }
  })
end
