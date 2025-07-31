return function()
  local autocmd = vim.api.nvim_create_autocmd
  local augroup = vim.api.nvim_create_augroup("lsp.cfg", { clear = true })
  local map_opts = { silent = true }
  local map = vim.keymap.set
  local fzf = require("fzf-lua")
  map("n", "<leader>ld", vim.diagnostic.open_float, map_opts)
  vim.lsp.enable("ts_ls")
  vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find({ "tsconfig.json", "package.json" }, { upward = true })[1]),
    filetypes = { "typescript", "typescriptreact" },
  })

  vim.lsp.enable("lua_ls")
  vim.lsp.config("lua_ls", {
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
            "screen",
          },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            ["/usr/share/awesome/lib"] = true,
          },
        },
      },
    },
  })

  vim.lsp.enable("clangd")
  vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index" },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    root_dir = vim.fn.getcwd(),
    filetypes = { "c", "cpp" },
  })

  vim.lsp.enable("bashls")
  vim.lsp.config("bashls", {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh, zsh" },
    root_dir = vim.fn.getcwd(),
  })

  vim.lsp.enable("yamlls")
  vim.lsp.config("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    root_dir = vim.fn.getcwd(),
  })

  vim.lsp.enable("jsonls")
  vim.lsp.config("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json" },
    root_dir = vim.fn.getcwd(),
  })
  local chars = {}
  for i = 32, 126 do
    table.insert(chars, string.char(i))
  end
  local pumMap = function(insertKmap, pumKmap)
    map("i", insertKmap, function()
      if vim.fn.pumvisible() == 0 then
        return insertKmap
      else
        return pumKmap
      end
    end, { expr = true })
  end
  autocmd("LspAttach", {
    group = augroup,
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/implementation") then
        local bufopts = { noremap = true, silent = true, buffer = args.buf }
        map("n", "gd", fzf.lsp_definitions, bufopts)
        map("n", "gD", fzf.lsp_typedefs, bufopts)
        map("n", "K", vim.lsp.buf.hover, bufopts)
        map("n", "gr", fzf.lsp_references, bufopts)
        map("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
        map("n", "<leader>o", fzf.lsp_document_symbols, bufopts)
        map({ "n", "i" }, "<S-Down>", vim.diagnostic.goto_next, bufopts)
        map({ "n", "i" }, "<S-Up>", vim.diagnostic.goto_prev, bufopts)
        pumMap("<Down>", "<C-n>")
        pumMap("<Up>", "<C-p>")
        pumMap("<CR>", "<C-y>")
      end
      if client:supports_method("textDocument/completion") then
        client.server_capabilities.completionProvider.triggerCharacters = chars
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      end
    end,
  })
end
