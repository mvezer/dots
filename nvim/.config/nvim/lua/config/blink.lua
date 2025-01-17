return function ()
  require("blink.cmp").setup({
    keymap = { preset = "enter" },
    -- completion = { list = { selection = { preselect = true,  auto_insert = false } } }
    completion = { list = { selection = {
      preselect = function (ctx)
        return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active({ direction = 1 })
      end,
      auto_insert = false,
    } } }
  })
end
