-- Make LazyVim's UI resemble plain Neovim + netrw.
-- Everything here just disables LazyVim's default "noisy" UI plugins;
-- LSP / completion / treesitter are untouched.
return {
  -- Fancy statusline -> fall back to the native one
  -- (statusline string is set in config/options.lua)
  { "nvim-lualine/lualine.nvim", enabled = false },

  -- Buffer/tab bar across the top
  { "akinsho/bufferline.nvim", enabled = false },

  -- Fancy cmdline / messages / popupmenu -> native cmdline
  { "folke/noice.nvim", enabled = false },

  -- File tree -> use plain netrw instead
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  { "nvim-mini/mini.pairs", enabled = false },
  { 
    "snacks.nvim", 
    opts = { 
      words = { 
        enabled = false 
      } 
    } 
  }
}
