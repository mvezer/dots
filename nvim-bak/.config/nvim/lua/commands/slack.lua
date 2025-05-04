-- vim.api.nvim_create_user_command("YankSelectedToSlack", function()
-- 	vim.cmd("'<,'>w !pandoc -f gfm | pbcopy")
-- end, { nargs = "?" })

vim.api.nvim_create_user_command("YankAllToSlack", function()
	vim.cmd("%w !pandoc -f gfm | pbcopy")
end, { nargs = "?" })
