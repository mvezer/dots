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
	{
		"folke/flash.nvim",
    -- version = "2.1.0",
		event = "VeryLazy",
		opts = {},
	},

  --- catppuccin (https://github.com/catppuccin/nvim)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- version = "1.9.0",
    priority = 1000,
    config = require("config.catppuccin"),
  },

	--- which-key (https://github.com/folke/which-key.nvim)
	{
		"folke/which-key.nvim",
    -- version = "3.16.0",
		event = "VeryLazy",
		config = require("config.which-key"),
	},

	--- lualine (https://github.com/nvim-lualine/lualine.nvim)
	{
		"nvim-lualine/lualine.nvim",
    -- commit = "f4f791f",
		lazy = true,
		event = "BufRead",
		config = require("config.lualine"),
	},

	--- gitsigns (https://github.com/lewis6991/gitsigns.nvim)
	{
		"lewis6991/gitsigns.nvim",
    -- version = "1.0.1",
		lazy = true,
		event = "BufRead",
		opts = {},
	},

	--- markdown preview (https://github.com/iamcco/markdown-preview.nvim)
	{
		"iamcco/markdown-preview.nvim",
    -- version = "0.0.10",
		lazy = true,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		config = require("config.markdown-preview"),
		ft = { "markdown" },
	},

  -- markview (https://github.com/OXY2DEV/markview.nvim?tab=readme-ov-file#-installation)
  {
    "OXY2DEV/markview.nvim",
    -- version = "25.3.1",
    lazy = false,
    config = require("config.markview")
  },

	--- marks (https://github.com/chentoast/marks.nvim)
	{
		"chentoast/marks.nvim",
    -- commit = "bb25ae3",
		config = require("config.marks"),
	},

	--- snacks (https://github.com/folke/snacks.nvim)
	{
		"folke/snacks.nvim",
    -- version = "2.20.0",
		priority = 1000,
		lazy = false,
		config = require("config.snacks"),
	},

	--- snipe (https://github.com/leath-dub/snipe.nvim)
	-- {
	-- 	"leath-dub/snipe.nvim",
	--    commit = "0d0a482",
	-- 	event = "VeryLazy",
	-- 	config = require("config.snipe"),
	-- },

	--- suda (https://github.com/lambdalisue/suda.vim)
	{
		"lambdalisue/suda.vim",
    -- version = "1.2.4",
		lazy = true,
		cmd = { "SudaWrite", "SudaRead" },
	},

  --- nvim-treesitter-textobjects (https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufReadPost",
    config = require("config.treesitter-textobjects"),
		dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

	--- TreeSJ (split/join) (https://github.com/Wansmer/treesj)
	{
		"Wansmer/treesj",
    -- commit = "48c1a75",
		lazy = true,
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = require("config.treesj"),
	},

	--- url-open (https://github.com/sontungexpt/url-open)
	{
		"sontungexpt/url-open",
    -- version = "1.7.1",
		branch = "mini",
		event = "VeryLazy",
		cmd = "URLOpenUnderCursor",
		opts = {},
	},

	--- vim eunuch (https://github.com/tpope/vim-eunuch)
	{ "tpope/vim-eunuch" },

	--- LSP
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			--- mason (https://github.com/williamboman/mason.nvim)
			-- { "williamboman/mason.nvim", opts = {}, version = "1.11.0" },
			{ "williamboman/mason.nvim", opts = {}, version = "*" },
			{ "folke/lsp-colors.nvim", version = "*" },
			{ "folke/neodev.nvim", opts = {} },
      -- { "neovim/nvim-lspconfig", version = "1.6.0" },
      { "neovim/nvim-lspconfig", version = "*" },
      { "nvim-lua/plenary.nvim", version = "*" },
      { "ray-x/lsp_signature.nvim", version = "*" },
			{
				--- blink.cmp (https://github.com/Saghen/blink.cmp)
				"saghen/blink.cmp",
				version = "0.12.4",
        dependencies = {
          { "saghen/blink.compat", lazy = true, version = "*" },
          -- { "giuxtaposition/blink-cmp-copilot", commit = "5d4ed42" },
        },
				config = require("config.blink"),
			},
		},
		config = require("config.lsp"),
	},

	--- fidget (https://github.com/j-hui/fidget.nvim)
	{
		"j-hui/fidget.nvim",
		version = "*",
		opts = {},
	},

	--- copilot (https://github.com/zbirenbaum/copilot.lua)
	-- {
	-- 	"zbirenbaum/copilot.lua",
	--    commit = "30321e3",
	-- 	lazy = true,
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = require("config.copilot"),
	-- },

	--- conform (https://github.com/stevearc/conform.nvim)
	{
		"stevearc/conform.nvim",
    version = "*",
		lazy = true,
		cmd = "Format",
		event = "BufWritePre",
		config = require("config.conform"),
	},

  -- nvim-recorder (https://github.com/chrisgrieser/nvim-recorder)
  {
    "chrisgrieser/nvim-recorder",
    commit = "00644d6",
    opts = {},
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
	{
		"stevearc/quicker.nvim",
    version = "*",
		event = "FileType qf",
		opts = {},
	},

  -- tmux neovim navigation (https://github.com/alexghergh/nvim-tmux-navigation)
  {
    "alexghergh/nvim-tmux-navigation",
    commit = "4898c98",
    opts = {}
  },

  -- noice (https://github.com/folke/noice.nvim)
  {
    "folke/noice.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = require("config.noice")
  },

  -- obsidian (https://github.com/epwalsh/obsidian.nvim)
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    -- dependencies  = {
      --- telescope (https://github.com/nvim-telescope/telescope.nvim)
    --   {
    --     "nvim-telescope/telescope.nvim",
    --     version = "0.1.8",
    --     lazy = true,
    --     cmd = { "Telescope" },
    --     dependencies = {
    --       { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    --     },
    --     config = require("config.telescope"),
    --   },
    -- },
    config = require("config.obsidian")
  },

  -- supermaven (https://github.com/supermaven-inc/supermaven-nvim)
  {
    "supermaven-inc/supermaven-nvim",
    -- commit = "07d20fc",
    config = require("config.supermaven")
  },

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
      --- The below dependencies are optional,
      -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "echasnovski/mini.icons",
      "Kaiser-Yang/blink-cmp-avante"
    }
  },

  --- vuffers (https://github.com/Hajime-Suzuki/vuffers.nvim)
  {
    "Hajime-Suzuki/vuffers.nvim",
    -- dir = "~/workspace/vuffers-picker.nvim/",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "Tastyep/structlog.nvim",
    },
    opts = {},
  },

  --- vim-prisma (https://github.com/prisma/vim-prisma)
  --- NOTE: for some reason the treesitter prisma syntax highlighting is not working
  --- while the issue is not resolved, this plugin provides the syntax highlighting
  --- (see issue: https://github.com/victorhqc/tree-sitter-prisma/issues/43)
  {
    "prisma/vim-prisma",
    lazy = false
  },

  {
    "akinsho/toggleterm.nvim",
    config = require("config.toggleterm")
  },

  {
    -- You can also use the codeberg mirror if you want to use the plugin without relying on GitHub
    -- "https://codeberg.org/CodingThunder/zincoxide.git" -- for HTTPS
    -- "git@codeberg.org:CodingThunder/zincoxide.git"     -- for SSH
    -- NOTE: the username on both github and codeberg are different
    "thunder-coding/zincoxide",
    opts = {
      -- name of zoxide binary in your "$PATH" or path to the binary
      -- the command is executed using vim.fn.system()
      -- eg. "zoxide" or "/usr/bin/zoxide"
      zincoxide_cmd = "zoxide",
      -- Kinda experimental as of now
      complete = true,
      -- Available options { "tabs", "window", "global" }
      behaviour = "tabs",
    },
    cmd = { "Z", "Zg", "Zt", "Zw" },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = require("config.bufferline")
  },
  {
    "notjedi/nvim-rooter.lua",
    config = require("config.nvim-rooter")
  }
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
