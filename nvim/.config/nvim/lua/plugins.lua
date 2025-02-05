-----------------------------------------------------------------------------------------------
--- Plugins
-----------------------------------------------------------------------------------------------

local plugin_specs = {
	--- flash (https://github.com/folke/flash.nvim)
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
	},

	--- kanagawa (https://github.com/rebelot/kanagawa.nvim)
	{
		"rebelot/kanagawa.nvim",
		config = require("config.kanagawa"),
	},

	--- which-key (https://github.com/folke/which-key.nvim)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = require("config.which-key"),
	},

	--- lualine (https://github.com/nvim-lualine/lualine.nvim)
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = "BufRead",
		config = require("config.lualine"),
	},

	--- gitsigns (https://github.com/lewis6991/gitsigns.nvim)
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufRead",
		opts = {},
	},

	--- markdown preview (https://github.com/iamcco/markdown-preview.nvim)
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		config = require("config.markdown-preview"),
		ft = { "markdown" },
	},

  --- render markdown (https://github.com/MeanderingProgrammer/render-markdown.nvim)
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   opts = {},
  -- },
  -- markview (https://github.com/OXY2DEV/markview.nvim?tab=readme-ov-file#-installation)
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = require("config.markview")
  },

	--- marks (https://github.com/chentoast/marks.nvim)
	{
		"chentoast/marks.nvim",
		config = require("config.marks"),
	},

  -- neo-tree (https://github.com/nvim-neo-tree/neo-tree.nvim)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = require("config.neotree")
  },

	--- snacks (https://github.com/folke/snacks.nvim)
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = require("config.snacks"),
	},

	--- snipe (https://github.com/leath-dub/snipe.nvim)
	{
		"leath-dub/snipe.nvim",
		event = "VeryLazy",
		config = require("config.snipe"),
	},

	--- snipe marks (https://github.com/nicholasxjy/snipe-marks.nvim)
	{
		"nicholasxjy/snipe-marks.nvim",
		dependencies = { "leath-dub/snipe.nvim" },
	},

	--- suda (https://github.com/lambdalisue/suda.vim)
	{
		"lambdalisue/suda.vim",
		lazy = true,
		cmd = { "SudaWrite", "SudaRead" },
	},

	--- telescope (https://github.com/nvim-telescope/telescope.nvim)
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		lazy = true,
		cmd = { "Telescope" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "debugloop/telescope-undo.nvim" },
			{
				"acksld/nvim-neoclip.lua",
				dependencies = {
					{
						"kkharji/sqlite.lua",
						module = "sqlite",
					},
				},
				opts = {},
			},
		},
		config = require("config.telescope"),
	},

	--- TreeSJ (split/join) (https://github.com/Wansmer/treesj)
	{
		"Wansmer/treesj",
		lazy = true,
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = require("config.treesj"),
	},

	--- ufo (https://github.com/kevinhwang91/nvim-ufo)
	-- {}

	--- url-open (https://github.com/sontungexpt/url-open)
	{
		"sontungexpt/url-open",
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
			{ "williamboman/mason.nvim", opts = {} },
      -- deactivate lsp-timeout, annoying messages
			-- "hinell/lsp-timeout.nvim",
			"folke/lsp-colors.nvim",
			{ "folke/neodev.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"ray-x/lsp_signature.nvim",
			{
				--- blink.cmp (https://github.com/Saghen/blink.cmp)
				"saghen/blink.cmp",
				version = "v0.*",
        dependencies = { "saghen/blink.compat", lazy = true, verson = false },
				config = require("config.blink"),
			},
		},
		config = require("config.lsp"),
	},

	--- fidget
	{
		"j-hui/fidget.nvim",
		tag = "v1.5.0",
		opts = {},
	},

	--- copilot (https://github.com/zbirenbaum/copilot.lua)
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		cmd = "Copilot",
		event = "InsertEnter",
		config = require("config.copilot"),
	},

	--- conform (https://github.com/stevearc/conform.nvim)
	{
		"stevearc/conform.nvim",
		lazy = true,
		cmd = "Format",
		event = "BufWritePre",
		config = require("config.conform"),
	},

  -- nvim-recorder (https://github.com/chrisgrieser/nvim-recorder)
  {
    "chrisgrieser/nvim-recorder",
    opts = {},
  },

	--- ufo (https://github.com/kevinhwang91/nvim-ufo)
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = { "kevinhwang91/promise-async" },
		config = require("config.ufo"),
	},

	--- quicker (https://github.com/stevearc/quicker.nvim)
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		opts = {},
	},

  -- tmux neovim navigation (https://github.com/alexghergh/nvim-tmux-navigation)
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {}
  },

  -- noice (https://github.com/folke/noice.nvim)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = require("config.noice")
  },

  -- obsidian
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = false,
    -- ft = "markdown",
    -- replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
      --   -- if you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      --   -- e.g. "bufreadpre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      --   -- refer to `:h file-pattern` for more examples
      --   "bufreadpre path/to/my-vault/*.md",
      --   "bufnewfile path/to/my-vault/*.md",
      -- },
      dependencies = {
        -- required.
        "nvim-lua/plenary.nvim",
      },
      config = require("config.obsidian")
    },
    {
      "swaits/zellij-nav.nvim",
      lazy = true,
      event = "VeryLazy",
      -- keys = {
      --   { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { silent = true, desc = "navigate left or tab"  } },
      --   { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down"  } },
      --   { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up"    } },
      --   { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
      -- },
      opts = {},
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
