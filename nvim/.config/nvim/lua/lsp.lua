require("lspconfig").helm_ls.setup({
  settings = {
    ["helm-ls"] = {
      yamlls = { path = "yaml-language-server" },
    },
  },
})
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { ".git" },
})
vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = true,
})
local pumMaps = {
  ["<Down>"] = "<C-n>",
  ["<Up>"] = "<C-p>",
  ["<Right>"] = "<C-y>", -- select item with <Tab>
  ["<CR>"] = "<C-e><CR>", -- close the pum and insert a new line
}
for insertKmap, pumKmap in pairs(pumMaps) do
  vim.keymap.set("i", insertKmap, function()
    return vim.fn.pumvisible() == 1 and pumKmap or insertKmap
  end, { expr = true })
end

function ToggleInlineDiagnostics()
  local current_value = vim.diagnostic.config().virtual_text
  if current_value then
    vim.diagnostic.config({ virtual_text = false })
  else
    vim.diagnostic.config({ virtual_text = true })
  end
end
vim.api.nvim_create_user_command("ToggeleInlineDiagnostics", ToggleInlineDiagnostics, {})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local FzfLua = require("fzf-lua")
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client.server_capabilities.completionProvider ~= nil then
      client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm. ", "")
    end
    -- LSP keymap
    vim.keymap.set("n", "gd", function()
      FzfLua.lsp_definitions()
    end, { buffer = true })
    vim.keymap.set("n", "gr", function()
      FzfLua.lsp_references()
    end, { buffer = true, noremap = true })
    vim.keymap.set("n", "<leader>lf", "<CMD>lua vim.diagnostic.open_float()<CR>", { buffer = true, noremap = true })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { noremap = true })
    vim.keymap.set("n", "<leader>ld", ":ToggeleInlineDiagnostics<CR>", { buffer = true, noremap = true, silent = true })
    vim.keymap.set("n", "<leader>o", function()
      FzfLua.lsp_document_symbols()
    end, { buffer = true, noremap = true })
    vim.keymap.set("n", "<leader>lv", function()
      vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
        -- virtual_text = not vim.diagnostic.config().virtual_text,
      })
    end, { buffer = true, noremap = true })
    vim.api.nvim_create_autocmd({ "TextChangedI" }, {
      buffer = args.buf,
      callback = function()
        vim.lsp.completion.get()
      end,
    })
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

    local _, cancel_prev = nil, function() end
    vim.api.nvim_create_autocmd("CompleteChanged", {
      buffer = args.buf,
      callback = function()
        cancel_prev()
        local info = vim.fn.complete_info({ "selected" })
        local completionItem = vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item")
        if nil == completionItem then
          return
        end
        _, cancel_prev = vim.lsp.buf_request(
          args.buf,
          vim.lsp.protocol.Methods.completionItem_resolve,
          completionItem,
          -- function(err, item, ctx)
          function(_, item)
            if not item then
              return
            end
            local docs = (item.documentation or {}).value
            local win = vim.api.nvim__complete_set(info["selected"], { info = docs })
            if win.winid and vim.api.nvim_win_is_valid(win.winid) then
              vim.treesitter.start(win.bufnr, "markdown")
              vim.wo[win.winid].conceallevel = 3
            end
          end
        )
      end,
    })
  end,
})
