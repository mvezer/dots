-- Format command
vim.api.nvim_create_user_command("FormatBuffer", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

-- Disable/enable autoformat on save
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})

-- Toggle autoformat on save
vim.api.nvim_create_user_command("FormatToggle", function(args)
	if args.bang then
		if vim.b.disable_autoformat then
			vim.b.disable_autoformat = false
		else
			vim.b.disable_autoformat = true
		end
	else
		if vim.g.disable_autoformat then
			vim.g.disable_autoformat = false
		else
			vim.g.disable_autoformat = true
		end
	end
end, {
	desc = "Toggle autoformat-on-save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})
