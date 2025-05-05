local plugin_spec = {
	{ "williamboman/mason.nvim", opts = {} },
	{ "folke/lazydev.nvim", opts = {} },
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})
		end,
	},
	{ "j-hui/fidget.nvim", opts = {} },
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme nightfox]])
		end,
	},
	{ "chentoast/marks.nvim", event = "VeryLazy", opts = {} },
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = { labels = "neioarst" },
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
	{
		"beauwilliams/statusline.lua",
		dependencies = {
			"nvim-lua/lsp-status.nvim",
		},
		opts = { match_colorscheme = true },
	},
	{
		"leath-dub/snipe.nvim",
		keys = {
			{
				"<leader><leader>",
				function()
					require("snipe").open_buffer_menu()
				end,
				desc = "Open Snipe buffer menu",
			},
		},
		opts = { hints = { dictionary = "neioarst" }, ui = { open_win_override = { border = "rounded" } } },
	},
	{ "nvim-treesitter/nvim-treesitter", opts = {} },
	{ "ibhagwan/fzf-lua", opts = {} },
	{ "supermaven-inc/supermaven-nvim", opts = { keymaps = { accept_suggestion = "<S-Tab>" } } },
	{
		-- Make sure to set this up properly if you have lazy=true
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "markdown", "Avante" },
		},
		ft = { "markdown", "Avante" },
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make",
		config = require("ai").setup_avante,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = false,
		opts = {
			filesystem = {
				commands = { avante_add_files = require("ai").avante_add_files },
			},
			window = { mappings = { ["A"] = "avante_add_files" } },
		},
	},
	{ "stevearc/conform.nvim", opts = require("format") },
	{ "kdheepak/lazygit.nvim" },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			vim.cmd([[do FileType]])
			vim.cmd([[
         function OpenMarkdownPreview (url)
            let cmd = "open -n -a \"/Applications/Brave Browser.app\" --args --new-window ". shellescape(a:url)
            silent call system(cmd)
         endfunction
      ]])
			-- make it OS-dependent - "open" does not work on linux
			vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
		end,
		ft = { "markdown" },
	},
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = plugin_spec,
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	-- checker = { enabled = true },
})
