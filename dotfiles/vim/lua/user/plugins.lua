-- Automatically install lazy.nvim
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
-- vim.opt.rtp:prepend(lazypath)
-- vim.loader.enable()

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Install your plugins here
return lazy.setup({
  -- Colorscheme
  {
    "arzg/vim-colors-xcode",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      local colorscheme = os.getenv("COLORSCHEME") or "xcodelighthc"
      vim.cmd.colorscheme(colorscheme)
    end,
  },
  -- Other color stuff
  { "ap/vim-css-color" }, -- Add color to .css files
  { "p00f/nvim-ts-rainbow" }, -- Rainbows!

  -- Git related plugins
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },

  -- Tpope
  { 'tpope/vim-surround' },
  { 'tpope/vim-ragtag' },

  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

  { "mattn/emmet-vim" }, -- HTML shortcuts
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
  { "nvim-lua/popup.nvim" }, -- Experimental popup api
  { "numToStr/Comment.nvim" }, -- Comment stuff
  { "JoosepAlviste/nvim-ts-context-commentstring" }, -- Treesitter extension

  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim' },
    },
  },
  { "lukas-reineke/indent-blankline.nvim" },
  { "goolord/alpha-nvim" }, -- Startup screen
  { "b0o/schemastore.nvim" }, -- JSON schemas
  -- { 'folke/which-key.nvim', opts = {} }, -- Show a menu of keys available
  {
  	"ray-x/lsp_signature.nvim",
  	event = "BufRead",
  	config = function() require"lsp_signature".on_attach() end,
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp", -- The completion plugin
    dependencies = {
      -- snippets
      { 'hrsh7th/vim-vsnip' },
      { 'hrsh7th/vim-vsnip-integ' },
      { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

      -- Completions
    	{ "hrsh7th/cmp-buffer" }, -- buffer completions
    	{ "hrsh7th/cmp-path" }, -- path completions
    	{ "hrsh7th/cmp-vsnip" }, -- snippet completions
    	{ "hrsh7th/cmp-nvim-lsp" },
    	{ "hrsh7th/cmp-nvim-lua" },
    }
  },
  { "jose-elias-alvarez/null-ls.nvim" },-- for formatters and linters
--   use "Hoffs/omnisharp-extended-lsp.nvim"
--
-- 	-- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    }
  },
  -- Treesitter
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      { "Shopify/tree-sitter-liquid" },
      { "nvim-treesitter/nvim-treesitter-textobjects" }
    }
  },
  -- Git
  { "lewis6991/gitsigns.nvim" },
--   {
--       "kdheepak/lazygit.nvim",
--       -- optional for floating window border decoration
--       dependencies = {
--           "nvim-lua/plenary.nvim",
--       },
--   },
--
--   -- DAP
--   -- use "mfussenegger/nvim-dap"
--   -- use "rcarriga/nvim-dap-ui"
--   -- use "ravenxrz/DAPInstall.nvim"
--
})
