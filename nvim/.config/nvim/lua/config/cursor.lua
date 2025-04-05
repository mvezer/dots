return function()
	vim.api.nvim_set_hl(0, "Cursor", { bg = "#f5bf42", fg = "#1e1e2e" })
	vim.api.nvim_set_hl(0, "InactiveCursor", { fg = "#6c7086", bg = "#2a2b3c" })

	require("cursor").setup({
		-- overwrite_cursor = false,
		cursors = {
			{
				mode = "n",
				shape = "block",
				hl = "Cursor",
				replace = true,
			},
		},
		trigger = {
			strategy = {
				type = "custom",
			},
			cursors = {
				{
					mode = "n",
					blink = false,
					hl = "InactiveCursor",
				},
			},
		},
	})

	vim.api.nvim_create_autocmd("FocusLost", {
		callback = require("cursor.strategy.custom").trigger,
	})

	vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
		callback = require("cursor.strategy.custom").revoke,
	})
end
