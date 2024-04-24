-- vim.loader.enable()

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

vim.opt.runtimepath:prepend(lazypath)
vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")


-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local colorscheme = os.getenv("COLORSCHEME") or "xcodelighthc"

-- Install your plugins here
lazy.setup({
  -- Colorscheme
  {
    "arzg/vim-colors-xcode",
    -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      -- vim.opt.background = "dark"
      vim.cmd.colorscheme(colorscheme)
    end,
  },
  -- Other color stuff
  { "ap/vim-css-color" }, -- Add color to .css files
  -- Git related plugins
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },

  -- Tpope
  { 'tpope/vim-surround' },
  { 'tpope/vim-ragtag' },
  {
    'tpope/vim-commentary',
    config = function ()
      -- https://github.com/tpope/vim-commentary/issues/68
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"typescriptreact", "javascriptreact", "javascript", "typescript"},
        callback = function()
          vim.cmd[[
            if exists('g:context#commentstring#table')
              let g:context#commentstring#table['javascript.jsx'] = {
                          \ 'jsComment' : '// %s',
                          \ 'jsImport' : '// %s',
                          \ 'jsxStatment' : '// %s',
                          \ 'jsxRegion' : '{/*%s*/}',
                          \}
            endif
          ]]
        end,
      })
    end
  },
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

  { "mattn/emmet-vim" }, -- HTML shortcuts
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
  { "nvim-lua/popup.nvim" }, -- Experimental popup api

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
  { "goolord/alpha-nvim" }, -- Startup screen
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
  -- Treesitter causes major slowdowns on any semi-large TypeScript file.
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   version = false, -- last release is way too old and doesn't work on Windows
  --   build = ":TSUpdate",
  --   dependencies = {
  --     { "Shopify/tree-sitter-liquid" },
  --     { "p00f/nvim-ts-rainbow" }, -- Rainbows!
  --     { "numToStr/Comment.nvim" }, -- Comment stuff
  --     { "JoosepAlviste/nvim-ts-context-commentstring" }, -- Treesitter extension
  --   },
  --   config = function ()
  --     local configs = require("nvim-treesitter.configs")
  --
  --     local disable_fn = function(lang, bufnr) -- Disable in large C++ buffers
	 --      local filetypes = lang == "TelescopePrompt" or lang == "netrw" or lang == "markdown"
	 --      return filetypes or vim.api.nvim_buf_line_count(bufnr) > 2000
  --     end
  --
  --     configs.setup({
  --         ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
	 --  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	 --  disable = disable_fn,
  --         highlight = {
	 --    enable = true, -- false will disable the whole extension
	 --    disable = disable_fn, -- list of language that will be disabled
	 --  },
	 --  comment = {
	 --    enable = true
	 --  },
  --         rainbow = {
	 --    disable = disable_fn,
  --           enable = false,
  --           -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  --           extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --           max_file_lines = 2000, -- Do not enable for files with more than n lines, int
  --           -- colors = {}, -- table of hex strings
  --           -- termcolors = {} -- table of colour name strings
  --         }
  --       })
  --   end
  -- },
  -- Git
  { "lewis6991/gitsigns.nvim" },
  {
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
  },
--
--   -- DAP
--   -- use "mfussenegger/nvim-dap"
--   -- use "rcarriga/nvim-dap-ui"
--   -- use "ravenxrz/DAPInstall.nvim"
--
},
{
  install = {
    colorscheme = { colorscheme, "desert" },
  }
})

vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")


