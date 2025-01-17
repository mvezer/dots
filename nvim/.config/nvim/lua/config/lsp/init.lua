return function()
	local utils = require("config.lsp.lsp_utils")

	require("config.lsp.diagnostics_config")()

	vim.lsp.handlers["workspace/executeCommand"] = function(_, result, ctx)
		if ctx.params.command ~= "_typescript.goToSourceDefinition" or result == nil or #result == 0 then
			return
		end
		vim.lsp.util.jump_to_location(result[1], "utf-8")
	end

	local function goto_source_definition()
		local position_params = vim.lsp.util.make_position_params()
		vim.lsp.buf.execute_command({
			command = "_typescript.goToSourceDefinition",
			arguments = { vim.api.nvim_buf_get_name(0), position_params.position },
		})
	end

	local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		pattern = "LspAttached",
		group = group,
		desc = "LSP actions",
		callback = function(args)
			-- local client = vim.lsp.get_client_by_id(args.data.client_id)
			require("lsp_signature").on_attach(require("config.lsp.lsp-signature_config"), args.buf)

			utils.bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "LSP Hover")
			utils.bufmap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', "Go to definition")
			utils.bufmap(
				"n",
				"gD",
				'<cmd>lua require("telescope.builtin").lsp_declarations()<cr>',
				"Go to declaration(s)"
			)
			utils.bufmap(
				"n",
				"gi",
				'<cmd>lua require("telescope.builtin").lsp_implementations()<cr>',
				"Go to implementation(s)"
			)
			utils.bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition")
			utils.bufmap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', "Go to reference(s)")
			utils.bufmap("n", "gs", goto_source_definition)
			utils.bufmap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol")
			utils.bufmap(
				"n",
				"<leader>ll",
				'<cmd>lua require("telescope.builtin").diagnostics()<cr>',
				"Telescope diagnostic list"
			)
			utils.bufmap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP Code actions")
			utils.bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help")
			-- TODO: Add range_code_action
			-- utils.bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
		end,
	})

	local lsp_capabilities = require("blink.cmp").get_lsp_capabilities({})
	lsp_capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	local default_setup = function(server)
		require("lspconfig")[server].setup({
			capabilities = lsp_capabilities,
		})
	end
	require("mason").setup({})
	require("mason-lspconfig").setup({
		ensure_installed = {
			"cssls",
			"eslint",
			"html",
			"lua_ls",
			"ts_ls",
		},
		handlers = {
			default_setup,
			lua_ls = utils.create_config("lua_ls", lsp_capabilities),
			-- require("neodev").setup({})
			ts_ls = utils.create_config("ts_ls", lsp_capabilities),
		},
	})
end
