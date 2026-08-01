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
vim.opt.runtimepath:append("~/.vim/")

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
    dependencies = {
      "rebelot/kanagawa.nvim",
      "spaceduck-theme/nvim",
      { "catppuccin/nvim", name = "catppuccin" }
    },
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      -- vim.opt.background = "dark"
      vim.cmd.colorscheme(colorscheme)
    end,
  },
  -- Other color stuff
  -- { "ap/vim-css-color" }, -- Add color to .css files
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

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', opts = {} },
      { 'williamboman/mason-lspconfig.nvim' },
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      { 'saghen/blink.cmp', dependencies = { 'saghen/blink.lib' } },
    },
    config = function()
      -- keybindings etc.
      vim.filetype.add {
        extension = {
          -- njk = 'html.jinja',
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        local servers = {
          jinja_lsp = {
            capabilities = capabilities,
            filetypes = { "jinja", "html.jinja" },
            root_markers = { "package.json", ".git" },
            settings = {
              -- template_extensions = { "njk", "html.jinja" },
              templates = './src/pages',
              backend = { './src' },
              lang = "python"
            }
          }
        }
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      -- require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- For some reason `require("lspconfig")["jinja_lsp"] doesn't quite work right in v0.12 if neovim :shrug:`
      vim.lsp.config["jinja_lsp"] = servers.jinja_lsp
      require("mason").setup()
      require('mason-lspconfig').setup({
        automatic_enable = true
      })
    end
  },

  { "b0o/schemastore.nvim" }, -- JSON schemas
  -- { 'folke/which-key.nvim', opts = {} }, -- Show a menu of keys available
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function(_, opts)
  --     require('lsp_signature').setup({
  --       log_path = vim.fn.expand("$HOME") .. "/tmp/sig.log",
  --       debug = true,
  --       hint_enable = false,
  --       handler_opts = { border = "single" },
  --       max_width = 80,
  --     })
  --   end
  -- },
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
--   use "Hoffs/omnisharp-extended-lsp.nvim"
--
-- 	-- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  },
  -- Treesitter causes major slowdowns on any semi-large TypeScript file.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      local ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "elixir", "heex", "javascript", "html",
      }

      -- install only missing parsers so it doesn't recompile every startup
      local ok, cfg = pcall(require, "nvim-treesitter.config")
      local installed = ok and cfg.get_installed() or {}
      local missing = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
      end, ensure_installed)
      if #missing > 0 then ts.install(missing) end

      -- highlighting is core now: enable per-buffer with your old disable logic
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf = args.buf
          local ft = vim.bo[buf].filetype
          if ft == "markdown" or ft == "TelescopePrompt" or ft == "netrw" then
            return
          end
          if vim.api.nvim_buf_line_count(buf) > 2000 then
            return
          end
          -- starts treesitter highlighting; leaving 'syntax' on is the
          -- equivalent of your old additional_vim_regex_highlighting = true
          pcall(vim.treesitter.start, buf)
        end,
      })
    end,
  },
  -- Git
  -- { "lewis6991/gitsigns.nvim" },
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
  -- {
  --   "jdonaldson/vim-haxe",
  --   ft = "haxe",
  --   init = function()
  --     vim.g.loaded_haxecomplete = 1  -- match the actual guard var in that file
  --   end,
  -- }

},
{
  install = {
    colorscheme = { colorscheme, "desert" },
  }
})

vim.opt.runtimepath:append("~/.vim/")

require("plugins.lsp_test")
