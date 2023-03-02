local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "numToStr/Comment.nvim" -- Comment stuff
  use "JoosepAlviste/nvim-ts-context-commentstring" -- Treesitter extension
  use "lewis6991/impatient.nvim" -- Faster loading
  use "lukas-reineke/indent-blankline.nvim" -- Indent guide
  use "goolord/alpha-nvim"
  use "nvim-lua/popup.nvim" -- Experimental popup api
  use "folke/neodev.nvim" -- LSP stuff for plugins
  use "b0o/schemastore.nvim" -- JSON schemas
	use "folke/which-key.nvim" -- Show a menu of keys available

  -- Colorschemes
  use "lunarvim/lunar.nvim"
  use "arzg/vim-colors-xcode"
  use "mattn/emmet-vim"
  use "ap/vim-css-color" -- Add color to .css files
	use "p00f/nvim-ts-rainbow" -- Rainbows!

	use {
  	"ray-x/lsp_signature.nvim",
  	event = "BufRead",
  	config = function() require"lsp_signature".on_attach() end,
  }

  -- cmp plugins
  use {
  	"hrsh7th/nvim-cmp", -- The completion plugin
  	requires = {
  		"hrsh7th/cmp-buffer", -- buffer completions
  		"hrsh7th/cmp-path", -- path completions
  		"saadparwaiz1/cmp_luasnip", -- snippet completions
  		"hrsh7th/cmp-nvim-lsp",
  		"hrsh7th/cmp-nvim-lua",
  	}
  }
  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
    use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'williamboman/nvim-lsp-installer',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
    },
  }
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "Hoffs/omnisharp-extended-lsp.nvim"

	-- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Treesitter
	use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- DAP
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "ravenxrz/DAPInstall.nvim"

  -- Tpope
  use 'tpope/vim-surround'
  use 'tpope/vim-ragtag'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
