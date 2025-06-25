return function()
  vim.api.nvim_create_user_command("ConformToggle", function()
    vim.b.disable_autoformat = not vim.b.disable_autoformat
    -- print("Conform autoformatting " .. (vim.b.conform_disable and "disabled" or "enabled"))
  end, {})
  require("conform").setup({
    formatters = {
      my_prettier = {
        command = "prettier",
        args = { "--stdin-filepath", "$FILENAME" },
        cwd = require("conform.util").root_file({ ".prettierrc", "package.json" }),
      },
      rustfmt = {
        command = "/Users/mat/.cargo/bin/rustfmt",
        args = { "--emit=stdout", "--edition=2021" },
        cwd = require("conform.util").root_file({ "Cargo.toml" }),
      },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "my_prettier", "eslint", stop_after_first = true },
      typescript = { "my_prettier", "eslint", stop_after_first = true },
      typescriptreact = { "my_pretteier", "eslint", stop_after_first = true },
      javascriptreact = { "my_pretteier", "eslint", stop_after_first = true },
      css = { "my_pretteier", "eslint", stop_after_first = true },
      scss = { "my_pretteier", "eslint", stop_after_first = true },
      less = { "my_pretteier", "eslint", stop_after_first = true },
      json = { "my_pretteier", "eslint", stop_after_first = true },
      jsonc = { "my_pretteier", "eslint", stop_after_first = true },
      yaml = { "my_pretteier", "eslint", stop_after_first = true },
      markdown = { "my_pretteier", "eslint", stop_after_first = true },
      markdown_inline = { "my_pretteier", "eslint", stop_after_first = true },
      html = { "my_pretteier", "eslint", stop_after_first = true },
      css_inline = { "my_pretteier", "eslint", stop_after_first = true },
      scss_inline = { "my_pretteier", "eslint", stop_after_first = true },
      less_inline = { "my_pretteier", "eslint", stop_after_first = true },
      graphql = { "my_pretteier", "eslint", stop_after_first = true },
      graphql_inline = { "my_pretteier", "eslint", stop_after_first = true },
      solidity = { "my_pretteier", "eslint", stop_after_first = true },
      rust = { "rustfmt", lsp_format = "fallback" },
    },
  })
end
