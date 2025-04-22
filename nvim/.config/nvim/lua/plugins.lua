-- ______ _             _
-- | ___ \ |           (_)
-- | |_/ / |_   _  __ _ _ _ __  ___
-- |  __/| | | | |/ _` | | '_ \/ __|
-- | |   | | |_| | (_| | | | | \__ \
-- \_|   |_|\__,_|\__, |_|_| |_|___/
--                 __/ |
--                |___/
-----------------------------------------------------------------------------------------------

local plugin_specs = {
	--- flash (https://github.com/folke/flash.nvim)
	{ "folke/flash.nvim", version = "*", event = "VeryLazy", opts = {} },

	--- catppuccin (https://github.com/catppuccin/nvim)
	{ "catppuccin/nvim", name = "catppuccin", version = "*", priority = 1000, config = require("config.catppuccin") },

	--- which-key (https://github.com/folke/which-key.nvim)
	{ "folke/which-key.nvim", version = "*", event = "VeryLazy", config = require("config.which-key") },

	--- lualine (https://github.com/nvim-lualine/lualine.nvim)
	{ "nvim-lualine/lualine.nvim", lazy = true, event = "BufRead", config = require("config.lualine") },

	--- gitsigns (https://github.com/lewis6991/gitsigns.nvim)
	{ "lewis6991/gitsigns.nvim", version = "*", lazy = true, event = "BufRead", opts = {} },

	--- markdown preview (https://github.com/iamcco/markdown-preview.nvim)
	{
		"iamcco/markdown-preview.nvim",
		version = "*",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		config = require("config.markdown-preview"),
		ft = { "markdown" },
	},

	-- markview (https://github.com/OXY2DEV/markview.nvim?tab=readme-ov-file#-installation)
	{ "OXY2DEV/markview.nvim", version = "*", lazy = false, config = require("config.markview") },

	--- marks (https://github.com/chentoast/marks.nvim)
	{ "chentoast/marks.nvim", config = require("config.marks") },

	--- snacks (https://github.com/folke/snacks.nvim)
	{ "folke/snacks.nvim", priority = 1000, lazy = false, config = require("config.snacks") },

	--- suda (https://github.com/lambdalisue/suda.vim)
	{ "lambdalisue/suda.vim", lazy = true, cmd = { "SudaWrite", "SudaRead" } },

	--- nvim-treesitter-textobjects (https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = require("config.treesitter-textobjects"),
	},

	--- TreeSJ (split/join) (https://github.com/Wansmer/treesj)
	{
		"Wansmer/treesj",
		lazy = true,
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = require("config.treesj"),
	},

	--- url-open (https://github.com/sontungexpt/url-open)
	{ "sontungexpt/url-open", branch = "mini", event = "VeryLazy", cmd = "URLOpenUnderCursor", opts = {} },

	--- vim eunuch (https://github.com/tpope/vim-eunuch)
	{ "tpope/vim-eunuch" },

	--- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			--- mason (https://github.com/williamboman/mason.nvim)
			{ "williamboman/mason.nvim", opts = {}, version = "*" },
			"folke/snacks.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- { "folke/lsp-colors.nvim", version = "*" },
			{ "folke/neodev.nvim", opts = {} },
			{ "nvim-lua/plenary.nvim", version = "*" },
			-- { "ray-x/lsp_signature.nvim", version = "*" },
			--- fidget (https://github.com/j-hui/fidget.nvim)
			{ "j-hui/fidget.nvim", version = "*", opts = {} },
			{ "pmizio/typescript-tools.nvim", opts = {} },
			{
				--- blink.cmp (https://github.com/Saghen/blink.cmp)
				"saghen/blink.cmp",
				version = "*",
				dependencies = { { "saghen/blink.compat", lazy = true, version = "*" }, "allaman/emoji.nvim" },
				config = require("config.blink"),
			},
		},
		config = require("config.lsp"),
	},

	--- conform (https://github.com/stevearc/conform.nvim)
	{ "stevearc/conform.nvim", event = { "BufWritePre" }, cmd = { "ConformInfo" }, config = require("config.conform") },

	-- nvim-recorder (https://github.com/chrisgrieser/nvim-recorder)
	{
		"chrisgrieser/nvim-recorder",
		commit = "00644d6",
		opts = {
			mapping = {
				startStopRecording = "<C-q>",
				playMacro = "Q",
				switchSlot = "<C-S-q>",
				editMacro = "cq",
				deleteAllMacros = "dq",
				yankMacro = "yq",
				-- ⚠️ this should be a string you don't use in insert mode during a macro
				addBreakPoint = "##",
			},
		},
	},

	--- ufo (https://github.com/kevinhwang91/nvim-ufo)
	{
		"kevinhwang91/nvim-ufo",
		version = "1.4.0",
		event = "VeryLazy",
		dependencies = { "kevinhwang91/promise-async" },
		config = require("config.ufo"),
	},

	--- quicker (https://github.com/stevearc/quicker.nvim)
	{ "stevearc/quicker.nvim", event = "FileType qf", opts = {} },

	-- noice (https://github.com/folke/noice.nvim)
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = require("config.noice"),
	},

	-- supermaven (https://github.com/supermaven-inc/supermaven-nvim)
	{ "supermaven-inc/supermaven-nvim", config = require("config.supermaven") },

	--- avante (https://github.com/yetone/avante.nvim)
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = "*",
		config = require("config.avante"),
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.icons",
			"Kaiser-Yang/blink-cmp-avante",
		},
	},

	--- vim-prisma (https://github.com/prisma/vim-prisma)
	--- NOTE: for some reason the treesitter prisma syntax highlighting is not working
	--- while the issue is not resolved, this plugin provides the syntax highlighting
	--- (see issue: https://github.com/victorhqc/tree-sitter-prisma/issues/43)
	{ "prisma/vim-prisma", lazy = false },

	{ "akinsho/toggleterm.nvim", config = require("config.toggleterm") },
	{ "chomosuke/term-edit.nvim", event = "TermOpen", version = "1.*", opts = {} },
	{
		"nanotee/zoxide.vim",
		version = "*",
		dependencies = {
			{ "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
		},
	},
	{ "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons", config = require("config.bufferline") },
	{ "notjedi/nvim-rooter.lua", config = require("config.nvim-rooter") },
	{
		"allaman/emoji.nvim",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { enable_cmp_integration = true },
	},
	{
		"rasulomaroff/cursor.nvim",
		event = "VeryLazy",
		config = require("config.cursor"),
	},
	{ "smjonas/inc-rename.nvim", opts = {} },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = plugin_specs,
	rocks = {
		enabled = false,
	},
})
