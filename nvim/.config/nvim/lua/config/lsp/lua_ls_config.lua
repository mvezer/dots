return {
  -- on_init = function(client, _)
  -- Note that server_capabilities config shouldn't be done in on_attach
  -- due to delayed execution (see neovim/nvim-lspconfig#2542)
  -- if client.server_capabilities then
  --   client.server_capabilities.documentFormattingProvider = false
  -- end
  -- end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "uv" },
        disable = { "different-requires" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      format = { enable = false },
      telemetry = { enable = false },
      -- Do not override treesitter lua highlighting with lua_ls's highlighting
      semantic = { enable = false },
    },
  }
}
