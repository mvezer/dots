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
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim", "vim.loop", "vim.loop.os_uname", "vim.uv", "kong", "ngx" },
      },
      workspace = {
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
