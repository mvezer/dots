return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  format = function(client)
    vim.lsp.buf.format({ async = false, id = client.id })
  end,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = {
          "vim",
          "vim.loop",
          "vim.loop.os_uname",
          "vim.uv",
          "kong",
          "ngx",
          "awesome",
          "root",
          "client",
          "screen"
        },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          ["/usr/share/awesome/lib"] = true,
        }
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
