-- FzfLua
vim.keymap.set("n", "<leader>sr", function() FzfLua.oldfiles() end )
vim.keymap.set("n", "<leader>st", function() FzfLua.live_grep() end )
vim.keymap.set("n", "<leader>sz", function() FzfLua.zoxide() end )
vim.keymap.set("n", "<leader>sw", function() FzfLua.grep_cWORD() end )
vim.keymap.set("n", "<leader>sh", function() FzfLua.helptags() end )
vim.keymap.set("n", "<leader>sj", function() FzfLua.jumps() end )

