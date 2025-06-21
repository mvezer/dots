return function()
  require("zk").setup({
    picker = "fzf_lua",
    lsp = {
      -- `config` is passed to `vim.lsp.start(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
      },
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  })
end
