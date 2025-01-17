local M = {}

M.bufmap = function(mode, lhs, rhs, desc)
	local opts = { buffer = true, desc = desc }
	vim.keymap.set(mode, lhs, rhs, opts)
end

M.create_config = function(server, lsp_capabilities)
	return function()
		require("lspconfig")[server].setup(
			vim.tbl_deep_extend(
				"force",
				{ capabilities = lsp_capabilities },
				require("config.lsp." .. server .. "_config")
			)
		)
	end
end

return M
