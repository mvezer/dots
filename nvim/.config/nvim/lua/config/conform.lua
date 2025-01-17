return function()
	local autosave_ft_blacklist = { "sql", "typescript", "c" }

	require("conform").setup({
		formatters = {
			tidy = {
				command = function()
					local function reset_cursor_pos(pos)
						local num_rows = vim.api.nvim_buf_line_count(0)
						if pos[1] > num_rows then
							pos[1] = num_rows
						end

						vim.api.nvim_win_set_cursor(0, pos)
					end
					local cursor_pos = vim.api.nvim_win_get_cursor(0)
					vim.cmd([[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d_]])
					reset_cursor_pos(cursor_pos)
					return ""
				end,
			},
		},
		formatters_by_ft = {
			go = { "goimports", "gofmt" },
			lua = { "stylua" },
			typescript = { "eslint" },
			sql = { "pg_format" },
			["*"] = { "tidy" },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			if vim.list_contains(autosave_ft_blacklist, vim.bo.filetype) then
				return
			end

			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	})
end
