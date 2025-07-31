return function()
  local map_opts = { silent = true }
  local map = vim.keymap.set
  local dap = require("dap")
  local dap_view = require("dap-view")
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
      args = { "--port", "${port}" },
    },
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }
  dap.configurations.c = dap.configurations.cpp

  dap_view.setup({})
  map("n", "<leader>d", dap.continue, map_opts)
  map("n", "<leader>D", dap.disconnect, map_opts)
  map("n", "<leader>b", dap.toggle_breakpoint, map_opts)
  map("n", "<leader>w", dap_view.add_expr, map_opts)
  map("n", "<C-s>", dap.step_over, map_opts)
  map("n", "<C-i>", dap.step_into, map_opts)
end
