return function ()
  vim.diagnostic.config({
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "󰋼",
        [vim.diagnostic.severity.HINT] = "󰌵",
      },
    },
    float = {
      border = "rounded",
      format = function(d)
        return ("%s (%s) [%s]"):format(d.message, d.source, d.code or d.user_data.lsp.code)
      end,
    },
    underline = true,
    jump = {
      float = true,
    },
  })
  
  vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open diagnostic in a floating window" })
  vim.keymap.set("n", "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Previous diagnostic message" })
  vim.keymap.set("n", "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic message" })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      signs = true,
      underline = true,
      virtual_text = true,
      severity_limit = "Hint",
      update_in_insert = true,
    }
  )
end
