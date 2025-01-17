return function ()
  require("copilot").setup({
    -- cmp = {
      --   enabled = true,
      --   method = "getCompletionsCycling",
      -- },
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          accept = "<A-CR>",
          accept_word = "<A-Right>",
          accept_line = false,
          next = "<A-Tab>",
          prev = false,
          dismiss = "<Esc>",
        },
      },
      filetypes = {
        ["dap-repl"] = false,
        ["big_file_disabled_ft"] = false,
      },
    })
  end

